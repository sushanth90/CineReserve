
type NavbarProps = {
  user: { name?: string } | null;
  onLogout: () => void;
};

export default function Navbar({ user, onLogout }: NavbarProps) {
  const currentPath = window.location.pathname;

  return (
    <header className="navbar">
      <a className="brand" href="/" style={{ textDecoration: "none", color: "inherit" }}>
        <div className="brand-icon">C</div>
        <div>
          <h2>CineReserve</h2>
          <span>YOUR MOVIE EXPERIENCE</span>
        </div>
      </a>

      <nav className="nav-links">
        <a className={currentPath === "/" ? "active" : ""} href="/">
          Home
        </a>
        <a className={currentPath === "/movies" ? "active" : ""} href="/movies">
          Movies
        </a>
        <a
          className={currentPath === "/my-bookings" ? "active" : ""}
          href="/my-bookings"
        >
          My Bookings
        </a>
        <a className={currentPath === "/about" ? "active" : ""} href="/about">
          About
        </a>
        <a className={currentPath === "/contact" ? "active" : ""} href="/contact">
          Contact
        </a>
      </nav>

      {user ? (
        <div className="user-menu">
          <div className="user-profile">
            <div className="user-avatar">
              {user.name?.charAt(0).toUpperCase()}
            </div>
            <div className="user-details">
              <span className="user-welcome">WELCOME BACK</span>
              <strong>{user.name}</strong>
            </div>
          </div>
          <button className="logout-button" onClick={onLogout}>
            Logout
          </button>
        </div>
      ) : (
        <button
          className="login-button"
          onClick={() => {
            sessionStorage.setItem("loginRedirect", window.location.pathname);
            window.location.href = "/login";
          }}
        >
          Sign In
        </button>
      )}
    </header>
  );
}
