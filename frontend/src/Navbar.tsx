import { getCurrentRoute, getRouteHref, navigate } from "./nav";

type NavbarProps = {
  user: { name?: string } | null;
  onLogout: () => void;
};

export default function Navbar({ user, onLogout }: NavbarProps) {
  const currentPath = getCurrentRoute();

  return (
    <header className="navbar">
      <a
        className="brand"
        href={getRouteHref("/")}
        onClick={(e) => {
          e.preventDefault();
          navigate("/");
        }}
        style={{ textDecoration: "none", color: "inherit" }}
      >
        <div className="brand-icon">C</div>
        <div>
          <h2>CineReserve</h2>
          <span>YOUR MOVIE EXPERIENCE</span>
        </div>
      </a>

      <nav className="nav-links">
        <a
          className={currentPath === "/" ? "active" : ""}
          href={getRouteHref("/")}
          onClick={(e) => {
            e.preventDefault();
            navigate("/");
          }}
        >
          Home
        </a>
        <a
          className={currentPath === "/movies" ? "active" : ""}
          href={getRouteHref("/movies")}
          onClick={(e) => {
            e.preventDefault();
            navigate("/movies");
          }}
        >
          Movies
        </a>
        <a
          className={currentPath === "/my-bookings" ? "active" : ""}
          href={getRouteHref("/my-bookings")}
          onClick={(e) => {
            e.preventDefault();
            navigate("/my-bookings");
          }}
        >
          My Bookings
        </a>
        <a
          className={currentPath === "/about" ? "active" : ""}
          href={getRouteHref("/about")}
          onClick={(e) => {
            e.preventDefault();
            navigate("/about");
          }}
        >
          About
        </a>
        <a
          className={currentPath === "/contact" ? "active" : ""}
          href={getRouteHref("/contact")}
          onClick={(e) => {
            e.preventDefault();
            navigate("/contact");
          }}
        >
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
            sessionStorage.setItem("loginRedirect", window.location.hash || window.location.pathname);
            navigate("/login");
          }}
        >
          Sign In
        </button>
      )}
    </header>
  );
}
