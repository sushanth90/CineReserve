package com.cinereserve.service;

import com.cinereserve.dto.AuthResponse;
import com.cinereserve.dto.LoginRequest;
import com.cinereserve.dto.RegisterRequest;
import com.cinereserve.dto.UserDto;
import com.cinereserve.entity.User;
import com.cinereserve.exception.ConflictException;
import com.cinereserve.repository.UserRepository;
import com.cinereserve.security.JwtUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AuthService {

    private static final Logger log = LoggerFactory.getLogger(AuthService.class);

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtils jwtUtils;

    public AuthService(UserRepository userRepository, PasswordEncoder passwordEncoder, JwtUtils jwtUtils) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtUtils = jwtUtils;
    }

    @Transactional
    public AuthResponse register(RegisterRequest request) {
        String cleanEmail = request.getEmail().trim().toLowerCase();

        if (userRepository.existsByEmailIgnoreCase(cleanEmail)) {
            throw new ConflictException("An account with this email already exists.");
        }

        String encodedPassword = passwordEncoder.encode(request.getPassword());

        User user = User.builder()
                .name(request.getName().trim())
                .email(cleanEmail)
                .password(encodedPassword)
                .build();

        User savedUser = userRepository.save(user);
        log.info("User registered successfully with ID: {}", savedUser.getId());

        String token = jwtUtils.generateToken(savedUser.getId(), savedUser.getEmail(), savedUser.getName());

        return AuthResponse.builder()
                .message("Registration successful.")
                .user(toUserDto(savedUser))
                .token(token)
                .build();
    }

    @Transactional
    public AuthResponse login(LoginRequest request) {
        String cleanEmail = request.getEmail().trim().toLowerCase();

        User user = userRepository.findByEmailIgnoreCase(cleanEmail)
                .orElseThrow(() -> new BadCredentialsException("Invalid email or password."));

        boolean passwordMatches = verifyAndUpgradePassword(request.getPassword(), user);

        if (!passwordMatches) {
            throw new BadCredentialsException("Invalid email or password.");
        }

        String token = jwtUtils.generateToken(user.getId(), user.getEmail(), user.getName());
        log.info("User logged in successfully: {}", user.getEmail());

        return AuthResponse.builder()
                .message("Login successful.")
                .user(toUserDto(user))
                .token(token)
                .build();
    }

    @Transactional(readOnly = true)
    public UserDto getCurrentUser(String email) {
        User user = userRepository.findByEmailIgnoreCase(email)
                .orElseThrow(() -> new BadCredentialsException("User not found"));
        return toUserDto(user);
    }

    /**
     * Verifies the password using BCrypt.
     * If the stored password was legacy plaintext (from previous backend),
     * automatically upgrades it to a secure BCrypt hash in the database.
     */
    private boolean verifyAndUpgradePassword(String rawPassword, User user) {
        String storedPassword = user.getPassword();

        if (storedPassword == null) {
            return false;
        }

        // Check if stored password is an existing BCrypt hash
        if (storedPassword.startsWith("$2a$") || storedPassword.startsWith("$2b$") || storedPassword.startsWith("$2y$")) {
            return passwordEncoder.matches(rawPassword, storedPassword);
        }

        // Legacy plaintext comparison
        if (rawPassword.equals(storedPassword)) {
            log.info("Upgrading legacy plaintext password to BCrypt for user: {}", user.getEmail());
            user.setPassword(passwordEncoder.encode(rawPassword));
            userRepository.save(user);
            return true;
        }

        return false;
    }

    private UserDto toUserDto(User user) {
        return UserDto.builder()
                .id(user.getId())
                .name(user.getName())
                .email(user.getEmail())
                .username(user.getUsername())
                .build();
    }
}
