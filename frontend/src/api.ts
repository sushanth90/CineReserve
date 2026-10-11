// Centralized API configuration for CineReserve Full-Stack application

export const API_BASE_URL =
  (import.meta.env.VITE_API_BASE_URL as string) || "http://localhost:8080";

/**
 * Helper to get the saved JWT token from sessionStorage
 */
export function getAuthToken(): string | null {
  return sessionStorage.getItem("token");
}

/**
 * Standard headers helper including Content-Type and Bearer auth if logged in
 */
export function getAuthHeaders(): HeadersInit {
  const headers: Record<string, string> = {
    "Content-Type": "application/json",
  };
  const token = getAuthToken();
  if (token) {
    headers["Authorization"] = `Bearer ${token}`;
  }
  return headers;
}
