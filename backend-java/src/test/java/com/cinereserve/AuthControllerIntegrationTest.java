package com.cinereserve;

import com.cinereserve.dto.LoginRequest;
import com.cinereserve.dto.RegisterRequest;
import com.cinereserve.entity.User;
import com.cinereserve.repository.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

import static org.hamcrest.Matchers.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
@Transactional
class AuthControllerIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private UserRepository userRepository;

    @Test
    @DisplayName("Registration: successfully registers a new user with BCrypt hash and JWT")
    void testRegisterNewUser_Success() throws Exception {
        RegisterRequest request = RegisterRequest.builder()
                .name("Alice Wonder")
                .email("alice.test@cinereserve.com")
                .password("securePassword123")
                .build();

        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.message", containsString("Registration successful")))
                .andExpect(jsonPath("$.user.email", is("alice.test@cinereserve.com")))
                .andExpect(jsonPath("$.user.name", is("Alice Wonder")))
                .andExpect(jsonPath("$.token", notNullValue()));

        User savedUser = userRepository.findByEmailIgnoreCase("alice.test@cinereserve.com").orElse(null);
        assertNotNull(savedUser);
        assertTrue(savedUser.getPassword().startsWith("$2a$"), "Password must be BCrypt hashed");
    }

    @Test
    @DisplayName("Registration: duplicate email returns 409 Conflict")
    void testRegisterDuplicateEmail_Conflict() throws Exception {
        RegisterRequest request = RegisterRequest.builder()
                .name("Duplicate User")
                .email("sushanth123@gmail.com") // Already exists in database
                .password("password123")
                .build();

        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isConflict())
                .andExpect(jsonPath("$.message", is("An account with this email already exists.")));
    }

    @Test
    @DisplayName("Registration: validation fails for short password or invalid email (400 Bad Request)")
    void testRegisterValidationFailure() throws Exception {
        RegisterRequest request = RegisterRequest.builder()
                .name("Short Pass")
                .email("not-an-email")
                .password("123") // Less than 6 chars
                .build();

        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.status", is(400)));
    }

    @Test
    @DisplayName("Login: existing user logs in and plaintext password is transparently upgraded to BCrypt")
    void testLoginExistingUser_SuccessAndUpgrade() throws Exception {
        LoginRequest request = LoginRequest.builder()
                .email("sushanth123@gmail.com")
                .password("sushanth123")
                .build();

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message", is("Login successful.")))
                .andExpect(jsonPath("$.user.name", is("Sushanth")))
                .andExpect(jsonPath("$.user.email", is("sushanth123@gmail.com")))
                .andExpect(jsonPath("$.token", notNullValue()));

        User updatedUser = userRepository.findByEmailIgnoreCase("sushanth123@gmail.com").orElse(null);
        assertNotNull(updatedUser);
        assertTrue(updatedUser.getPassword().startsWith("$2a$"), "Legacy plaintext password must be upgraded to BCrypt");
    }

    @Test
    @DisplayName("Login: incorrect password returns 401 Unauthorized")
    void testLoginInvalidPassword_Unauthorized() throws Exception {
        LoginRequest request = LoginRequest.builder()
                .email("sushanth123@gmail.com")
                .password("wrongpassword123")
                .build();

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.message", is("Invalid email or password.")));
    }
}
