import { useState } from "react";
import { API_BASE_URL } from "./api";

function Login() {
  const [isRegister, setIsRegister] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const [message, setMessage] = useState("");
  const [error, setError] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
  e.preventDefault();

  setMessage("");
  setError("");
  setIsLoading(true);

  try {
    const endpoint = isRegister
      ? `${API_BASE_URL}/api/auth/register`
      : `${API_BASE_URL}/api/auth/login`;

    const body = isRegister
      ? {
          name,
          email,
          password,
        }
      : {
          email,
          password,
        };

    const response = await fetch(endpoint, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    });

    const data = await response.json();

    if (!response.ok) {
      setError(data.message || "Something went wrong.");
      return;
    }

    if (isRegister) {
      setMessage(`Registration successful! Welcome ${name}.`);
      setName("");
      setEmail("");
      setPassword("");
    } else {
      setMessage(`Login successful! Welcome back.`);

      sessionStorage.setItem("user", JSON.stringify(data.user));
      if (data.token) {
        sessionStorage.setItem("token", data.token);
      }

setTimeout(() => {
  const redirectPath =
    sessionStorage.getItem("loginRedirect") || "/";

  sessionStorage.removeItem("loginRedirect");

  window.location.href = redirectPath;
}, 500);
    }
  } catch (error) {
    console.error("Authentication error:", error);
    setError(
      "Unable to connect to the server. Make sure the backend is running."
    );
  } finally {
    setIsLoading(false);
  }
};

  const switchMode = () => {
    setIsRegister(!isRegister);
    setMessage("");
    setError("");
  };

  return (
    <div style={styles.page}>
      {/* Background */}
      <div style={styles.backgroundGlow}></div>
      <div style={styles.backgroundCircle}></div>

      {/* Back to Home */}
      <button
        type="button"
        onClick={() => {
          window.location.href = "/";
        }}
        style={styles.backButton}
      >
        ← Back to Home
      </button>

      <div style={styles.container}>
        {/* LEFT SIDE */}
        <section style={styles.heroSection}>
          <div style={styles.heroContent}>
            <div style={styles.logo}>
              <span style={styles.logoMark}>CR</span>
              <span>CineReserve</span>
            </div>

            <div style={styles.badge}>
              <span style={styles.badgeDot}></span>
              YOUR CINEMA EXPERIENCE
            </div>

            <h1 style={styles.heroTitle}>
              Your Movies.
              <br />
              Your Seats.
              <br />
              <span style={styles.redText}>Your Experience.</span>
            </h1>

            <p style={styles.heroText}>
              Everything you love about cinema, brought together in one
              seamless experience. Discover movies, choose your seats and
              manage every booking with ease.
            </p>

            <div style={styles.featureGrid}>
              <div style={styles.featureCard}>
                <div style={styles.featureIcon}>🎬</div>
                <div>
                  <strong style={styles.featureTitle}>Latest Movies</strong>
                  <small style={styles.featureText}>
                    Discover what's playing
                  </small>
                </div>
              </div>

              <div style={styles.featureCard}>
                <div style={styles.featureIcon}>💺</div>
                <div>
                  <strong style={styles.featureTitle}>
                    Easy Seat Booking
                  </strong>
                  <small style={styles.featureText}>
                    Choose your perfect seat
                  </small>
                </div>
              </div>

              <div style={styles.featureCard}>
                <div style={styles.featureIcon}>🎟️</div>
                <div>
                  <strong style={styles.featureTitle}>Digital Tickets</strong>
                  <small style={styles.featureText}>
                    Keep every booking organized
                  </small>
                </div>
              </div>

              <div style={styles.featureCard}>
                <div style={styles.featureIcon}>🔒</div>
                <div>
                  <strong style={styles.featureTitle}>Secure Experience</strong>
                  <small style={styles.featureText}>
                    Your account stays protected
                  </small>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* RIGHT SIDE */}
        <section style={styles.card}>
          <div style={styles.cardTop}>
            <div style={styles.cardLogo}>CR</div>

            <div>
              <p style={styles.cardEyebrow}>CINERESERVE ACCOUNT</p>

              <h2 style={styles.cardTitle}>
                {isRegister ? "Create your account" : "Welcome back"}
              </h2>

              <p style={styles.cardSubtitle}>
                {isRegister
                  ? "Join CineReserve and make your next movie night special."
                  : "Sign in to continue your cinema experience."}
              </p>
            </div>
          </div>

          {/* Mode tabs */}
          <div style={styles.modeTabs}>
            <button
              type="button"
              onClick={() => {
                setIsRegister(false);
                setMessage("");
                setError("");
              }}
              style={{
                ...styles.modeTab,
                ...(isRegister ? {} : styles.activeModeTab),
              }}
            >
              Sign In
            </button>

            <button
              type="button"
              onClick={() => {
                setIsRegister(true);
                setMessage("");
                setError("");
              }}
              style={{
                ...styles.modeTab,
                ...(isRegister ? styles.activeModeTab : {}),
              }}
            >
              Create Account
            </button>
          </div>

          <form onSubmit={handleSubmit}>
            {isRegister && (
              <div style={styles.field}>
                <label style={styles.label}>Full Name</label>

                <div style={styles.inputWrapper}>
                  <span style={styles.inputIcon}>👤</span>

                  <input
                    type="text"
                    placeholder="Enter your full name"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    required
                    style={styles.input}
                  />
                </div>
              </div>
            )}

            <div style={styles.field}>
              <label style={styles.label}>Email Address</label>

              <div style={styles.inputWrapper}>
                <span style={styles.inputIcon}>✉</span>

                <input
                  type="email"
                  placeholder="you@example.com"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  required
                  style={styles.input}
                />
              </div>
            </div>

            <div style={styles.field}>
              <div style={styles.passwordHeader}>
                <label style={styles.label}>Password</label>

                {!isRegister && (
                  <button
                    type="button"
                    onClick={() =>
                      alert("Password recovery will be added soon.")
                    }
                    style={styles.forgotButton}
                  >
                    Forgot password?
                  </button>
                )}
              </div>

              <div style={styles.inputWrapper}>
                <span style={styles.inputIcon}>🔒</span>

                <input
                  type={showPassword ? "text" : "password"}
                  placeholder="Enter your password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                  style={styles.input}
                />

                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  style={styles.eyeButton}
                  aria-label={
                    showPassword ? "Hide password" : "Show password"
                  }
                >
                  {showPassword ? "🙈" : "👁️"}
                </button>
              </div>

              {isRegister && (
                <p style={styles.passwordHint}>
                  Use at least 6 characters for your password.
                </p>
              )}
            </div>

            {error && (
              <div style={styles.errorMessage}>
                <span>⚠</span>
                {error}
              </div>
            )}

            {message && (
              <div style={styles.successMessage}>
                <span>✓</span>
                {message}
              </div>
            )}

            <button
              type="submit"
              disabled={isLoading}
              style={{
                ...styles.primaryButton,
                opacity: isLoading ? 0.75 : 1,
              }}
            >
              {isLoading ? (
                <>
                  <span style={styles.spinner}></span>
                  {isRegister ? "Creating Account..." : "Signing In..."}
                </>
              ) : (
                <>
                  {isRegister ? "Create Account" : "Sign In"}
                  <span style={styles.buttonArrow}>→</span>
                </>
              )}
            </button>
          </form>

          <div style={styles.divider}>
            <span style={styles.dividerLine}></span>
            <span style={styles.dividerText}>OR</span>
            <span style={styles.dividerLine}></span>
          </div>

          <p style={styles.switchText}>
            {isRegister
              ? "Already have a CineReserve account?"
              : "Don't have a CineReserve account?"}
          </p>

          <button
            type="button"
            onClick={switchMode}
            style={styles.secondaryButton}
          >
            {isRegister ? "Sign In Instead" : "Create New Account"}
          </button>

          <div style={styles.security}>
            <span>🔒</span>
            <span>Your information is securely protected.</span>
          </div>
        </section>
      </div>
    </div>
  );
}

const styles: { [key: string]: React.CSSProperties } = {
  page: {
    minHeight: "100vh",
    width: "100%",
    background:
      "radial-gradient(circle at 10% 15%, rgba(229,9,20,0.14), transparent 30%), radial-gradient(circle at 90% 80%, rgba(120,0,0,0.12), transparent 30%), #050505",
    color: "white",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    padding: "90px 40px 50px",
    boxSizing: "border-box",
    position: "relative",
    overflow: "hidden",
    fontFamily:
      "Inter, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif",
  },

  backgroundGlow: {
    position: "absolute",
    width: "420px",
    height: "420px",
    borderRadius: "50%",
    background: "rgba(229,9,20,0.08)",
    filter: "blur(110px)",
    top: "-180px",
    right: "-100px",
    pointerEvents: "none",
  },

  backgroundCircle: {
    position: "absolute",
    width: "280px",
    height: "280px",
    borderRadius: "50%",
    border: "1px solid rgba(255,255,255,0.035)",
    bottom: "-100px",
    left: "-80px",
    pointerEvents: "none",
  },

  backButton: {
    position: "absolute",
    top: "28px",
    left: "35px",
    background: "rgba(255,255,255,0.045)",
    border: "1px solid rgba(255,255,255,0.10)",
    color: "#ddd",
    padding: "11px 17px",
    borderRadius: "9px",
    cursor: "pointer",
    fontSize: "13px",
    transition: "0.2s",
  },

  container: {
    width: "100%",
    maxWidth: "1180px",
    display: "grid",
    gridTemplateColumns: "1fr 450px",
    gap: "85px",
    alignItems: "center",
    position: "relative",
    zIndex: 1,
  },

  heroSection: {
    padding: "10px",
  },

  heroContent: {
    maxWidth: "590px",
  },

  logo: {
    display: "flex",
    alignItems: "center",
    gap: "11px",
    color: "white",
    fontSize: "25px",
    fontWeight: 800,
    letterSpacing: "-0.8px",
    marginBottom: "45px",
  },

  logoMark: {
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    width: "40px",
    height: "40px",
    borderRadius: "10px",
    background: "#e50914",
    color: "white",
    fontSize: "13px",
    fontWeight: 900,
  },

  badge: {
    display: "inline-flex",
    alignItems: "center",
    gap: "8px",
    color: "#aaa",
    border: "1px solid rgba(255,255,255,0.09)",
    background: "rgba(255,255,255,0.035)",
    borderRadius: "30px",
    padding: "7px 12px",
    fontSize: "10px",
    letterSpacing: "1.3px",
    fontWeight: 700,
    marginBottom: "22px",
  },

  badgeDot: {
    width: "6px",
    height: "6px",
    borderRadius: "50%",
    background: "#e50914",
    boxShadow: "0 0 10px rgba(229,9,20,0.8)",
  },

  heroTitle: {
    color: "white",
    fontSize: "58px",
    lineHeight: 1.02,
    margin: "0 0 25px",
    fontWeight: 850,
    letterSpacing: "-3px",
  },

  redText: {
    color: "#e50914",
  },

  heroText: {
    color: "#999",
    fontSize: "16px",
    lineHeight: 1.75,
    maxWidth: "540px",
    marginBottom: "35px",
  },

  featureGrid: {
    display: "grid",
    gridTemplateColumns: "1fr 1fr",
    gap: "12px",
    maxWidth: "560px",
  },

  featureCard: {
    display: "flex",
    alignItems: "center",
    gap: "12px",
    padding: "14px",
    borderRadius: "11px",
    background: "rgba(255,255,255,0.025)",
    border: "1px solid rgba(255,255,255,0.055)",
  },

  featureIcon: {
    width: "37px",
    height: "37px",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    background: "rgba(229,9,20,0.09)",
    borderRadius: "9px",
    fontSize: "17px",
    flexShrink: 0,
  },

  featureTitle: {
    display: "block",
    color: "white",
    fontSize: "12px",
    marginBottom: "3px",
  },

  featureText: {
    display: "block",
    color: "#777",
    fontSize: "10px",
  },

  card: {
    background:
      "linear-gradient(145deg, rgba(25,25,25,0.97), rgba(13,13,13,0.97))",
    border: "1px solid rgba(255,255,255,0.10)",
    borderRadius: "20px",
    padding: "32px",
    boxShadow: "0 30px 80px rgba(0,0,0,0.6)",
    backdropFilter: "blur(20px)",
  },

  cardTop: {
    display: "flex",
    gap: "14px",
    alignItems: "flex-start",
    marginBottom: "25px",
  },

  cardLogo: {
    width: "46px",
    height: "46px",
    borderRadius: "12px",
    background: "#e50914",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    fontWeight: 900,
    fontSize: "14px",
    flexShrink: 0,
    boxShadow: "0 8px 25px rgba(229,9,20,0.22)",
  },

  cardEyebrow: {
    color: "#e50914",
    fontSize: "9px",
    letterSpacing: "1.4px",
    fontWeight: 800,
    margin: "2px 0 5px",
  },

  cardTitle: {
    color: "white",
    margin: 0,
    fontSize: "24px",
    fontWeight: 750,
    letterSpacing: "-0.6px",
  },

  cardSubtitle: {
    color: "#777",
    margin: "6px 0 0",
    fontSize: "12px",
    lineHeight: 1.5,
  },

  modeTabs: {
    display: "grid",
    gridTemplateColumns: "1fr 1fr",
    gap: "4px",
    padding: "4px",
    background: "#090909",
    borderRadius: "10px",
    marginBottom: "25px",
    border: "1px solid #222",
  },

  modeTab: {
    border: "none",
    background: "transparent",
    color: "#777",
    padding: "10px",
    borderRadius: "7px",
    cursor: "pointer",
    fontSize: "12px",
    fontWeight: 650,
  },

  activeModeTab: {
    background: "#e50914",
    color: "white",
    boxShadow: "0 4px 15px rgba(229,9,20,0.20)",
  },

  field: {
    marginBottom: "17px",
  },

  passwordHeader: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: "7px",
  },

  label: {
    display: "block",
    color: "#ddd",
    fontSize: "12px",
    fontWeight: 600,
  },

  inputWrapper: {
    display: "flex",
    alignItems: "center",
    width: "100%",
    boxSizing: "border-box",
    border: "1px solid #303030",
    background: "#090909",
    borderRadius: "9px",
    transition: "border-color 0.2s",
  },

  inputIcon: {
    width: "42px",
    textAlign: "center",
    color: "#666",
    fontSize: "13px",
    flexShrink: 0,
  },

  input: {
    flex: 1,
    minWidth: 0,
    boxSizing: "border-box",
    padding: "12px 5px",
    border: "none",
    background: "transparent",
    color: "white",
    fontSize: "13px",
    outline: "none",
  },

  eyeButton: {
    border: "none",
    background: "transparent",
    color: "#777",
    cursor: "pointer",
    padding: "10px 12px",
    fontSize: "13px",
  },

  forgotButton: {
    border: "none",
    background: "transparent",
    color: "#e50914",
    cursor: "pointer",
    fontSize: "10px",
    padding: 0,
  },

  passwordHint: {
    color: "#666",
    fontSize: "10px",
    margin: "6px 0 0",
  },

  errorMessage: {
    display: "flex",
    alignItems: "center",
    gap: "8px",
    background: "rgba(229,9,20,0.08)",
    border: "1px solid rgba(229,9,20,0.25)",
    color: "#ff7b82",
    padding: "10px 12px",
    borderRadius: "8px",
    fontSize: "11px",
    marginBottom: "15px",
  },

  successMessage: {
    display: "flex",
    alignItems: "center",
    gap: "8px",
    background: "rgba(40,180,100,0.08)",
    border: "1px solid rgba(40,180,100,0.22)",
    color: "#75d9a1",
    padding: "10px 12px",
    borderRadius: "8px",
    fontSize: "11px",
    marginBottom: "15px",
  },

  primaryButton: {
    width: "100%",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    gap: "10px",
    padding: "13px",
    border: "none",
    borderRadius: "9px",
    background: "#e50914",
    color: "white",
    fontSize: "13px",
    fontWeight: 750,
    cursor: "pointer",
    boxShadow: "0 8px 25px rgba(229,9,20,0.20)",
  },

  buttonArrow: {
    fontSize: "17px",
  },

  spinner: {
    width: "13px",
    height: "13px",
    border: "2px solid rgba(255,255,255,0.35)",
    borderTop: "2px solid white",
    borderRadius: "50%",
    display: "inline-block",
  },

  divider: {
    display: "flex",
    alignItems: "center",
    gap: "12px",
    margin: "22px 0 17px",
  },

  dividerLine: {
    flex: 1,
    height: "1px",
    background: "#292929",
  },

  dividerText: {
    color: "#555",
    fontSize: "9px",
    fontWeight: 700,
  },

  switchText: {
    color: "#777",
    textAlign: "center",
    fontSize: "11px",
    margin: "0 0 11px",
  },

  secondaryButton: {
    width: "100%",
    padding: "11px",
    border: "1px solid #383838",
    borderRadius: "9px",
    background: "transparent",
    color: "#ddd",
    fontSize: "12px",
    fontWeight: 600,
    cursor: "pointer",
  },

  security: {
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    gap: "6px",
    color: "#555",
    fontSize: "9px",
    marginTop: "20px",
  },
};

export default Login;