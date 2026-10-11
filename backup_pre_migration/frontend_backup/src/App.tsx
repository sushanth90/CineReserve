import { useState } from "react";
import "./App.css";
import Movies from "./Movies";
import Booking from "./Booking";
import Payment from "./Payment";
import Confirmation from "./Confirmation";
import Ticket from "./Ticket";
import About from "./About";
import Contact from "./Contact";
import Chatbot from "./Chatbot";
import Login from "./Login";
import MyBookings from "./MyBookings";
import Navbar from "./Navbar";
const movies = [
  {
    title: "Doctor Strange",
    genre: "Sci-Fi",
    rating: "7.5",
    duration: "1h 55m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["PVR Preston", "PVR Inorbit"],
    image: "/movies/doctor-strange.jpg",
  },
  {
    title: "Iron Man",
    genre: "Action",
    rating: "7.9",
    duration: "2h 06m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["AMB Cinemas", "PVR Atrium"],
    image: "/movies/iron-man.jpeg",
  },
  {
    title: "Thor: Ragnarok",
    genre: "Action",
    rating: "7.9",
    duration: "2h 10m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["PVR Preston", "PVR Inorbit"],
    image: "/movies/thor.jpeg",
  },
  {
    title: "Spider-Man: No Way Home",
    genre: "Action",
    rating: "8.2",
    duration: "2h 28m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["AMB Cinemas", "PVR Atrium"],
    image: "/movies/spider-man.jpeg",
  },
  {
    title: "Black Panther",
    genre: "Action",
    rating: "7.3",
    duration: "2h 14m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["AMB Cinemas", "PVR Inorbit"],
    image: "/movies/black-panther.jpeg",
  },
  {
    title: "Guardians of the Galaxy",
    genre: "Adventure",
    rating: "8.0",
    duration: "2h 01m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["AMB Cinemas", "PVR Atrium"],
    image: "/movies/guardians-of-the-galaxy.jpeg",
  },
  {
    title: "Ant-Man",
    genre: "Action",
    rating: "7.2",
    duration: "1h 57m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["PVR Preston", "PVR Inorbit"],
    image: "/movies/ant-man.jpg",
  },
  {
    title: "Avengers: Infinity War",
    genre: "Action",
    rating: "8.4",
    duration: "2h 29m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["AMB Cinemas", "PVR Atrium"],
    image: "/movies/avengers-infinity-war.jpg",
  },
  {
    title: "Avengers: Endgame",
    genre: "Action",
    rating: "8.4",
    duration: "3h 02m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["AMB Cinemas", "PVR Atrium"],
    image: "/movies/Avengers-Endgame.jpg",
  },
  {
    title: "INTERSTELLAR",
    genre: "Sci-Fi",
    rating: "8.7",
    duration: "2h 49m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["AMB Cinemas", "PVR Atrium"],
    image: "/movies/interstellar.jpg",
  },
  {
    title: "THE DARK KNIGHT",
    genre: "Action",
    rating: "9.0",
    duration: "2h 32m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["PVR Preston", "PVR Inorbit"],
    image: "/movies/the-dark-knight.jpg",
  },
  {
    title: "CINEMA NIGHT",
    genre: "Drama",
    rating: "8.5",
    duration: "2h 10m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["AMB Cinemas", "PVR Atrium"],
    image: "/movies/cinema-night.jpeg",
  },
];

const nowShowing = [
  {
    title: "The Last Journey",
    genre: "Drama",
    image:
      "/movies/the-last-journey.jpeg",
  },
  {
    title: "Midnight City",
    genre: "Thriller",
    image:
      "/movies/midnight-city.jpg",
  },
  {
    title: "Beyond Earth",
    genre: "Sci-Fi",
    image:
      "/movies/beyond-earth.jpeg",
  },
  {
    title: "The Adventure",
    genre: "Action",
    image:
      "/movies/the-adventure.jpg",
  },


];

const nearbyTheatres = [
  {
    name: "AMB Cinemas",
    area: "Gachibowli",
    distance: "2.4 km",
    rating: "4.6",
  },
  {
    name: "PVR Atrium",
    area: "Gachibowli",
    distance: "3.1 km",
    rating: "4.4",
  },
  {
    name: "PVR Preston",
    area: "Gachibowli",
    distance: "3.8 km",
    rating: "4.3",
  },
  {
    name: "PVR Inorbit",
    area: "Madhapur",
    distance: "6.2 km",
    rating: "4.2",
  },
];
const recommendedMovies = [
{
  title: "Doctor Strange",
  genre: "Action",
  rating: 7.5,
reason: "Because you enjoy Action movies",
  image: "/movies/doctor-strange.jpg",
},
  {
  title: "Iron Man",
  genre: "Action",
  rating: 7.9,
  reason: "Because you enjoy Action movies",
 image: "/movies/iron-man.jpeg",
},
{
  title: "Thor: Ragnarok",
  genre: "Action",
  rating: 7.9,
  reason: "Because you enjoy Action movies",
  image:"movies/thor.jpeg",
},
{
  title: "Spider-Man: No Way Home",
  genre: "Action",
  rating: 8.2,
  reason: "Because you enjoy Action movies",
   image: "movies/spider-man.jpeg",
},

{
  title: "Black Panther",
  genre: "Action",
  rating: 7.3,
  reason: "Because you enjoy Action movies",
  image: "movies/black-panther.jpeg",
},



{
  title: "Guardians of the Galaxy",
  genre: "Adventure",
  rating: 8.0,
  reason: "Because you enjoy Adventure movies",
  image: "movies/guardians-of-the-galaxy.jpeg",
   
},

{
  title: "Ant-Man",
  genre: "Adventure",
  rating: 7.2,
reason: "Because you enjoy Adventure movies",
  image:
    "movies/ant-man.jpg",
},

{
  title: "Avengers: Infinity War",
  genre: "Action",
  rating: 8.4,
  reason: "Because you enjoy Action movies",
  image:
    "movies/avengers-infinity-war.jpg",
},

{
  title: "Avengers: Endgame",
  genre: "Action",
  rating: 8.4,
  reason: "Because you enjoy Action movies",
  image:
    "movies/Avengers-Endgame.jpg",
},
{
  title: "The Dark Knight",
  genre: "Action",
  rating: 9.0,
  reason: "Because you enjoy Action movies",
  image: "/movies/the-dark-knight.jpg",
},
  {
    title: "The Last Journey",
    genre: "Drama",
    rating: 8.3,
    reason: "Because you like Adventure movies",
    image:
"/movies/the-last-journey.jpeg",
  },
  {
    title: "Midnight City",
    genre: "Thriller",
    rating: 8.3,
    reason: "Popular with Thriller fans",
    image:
      "/movies/midnight-city.jpg",
  },
  {
    title: "Beyond Earth",
    genre: "Sci-Fi",
    rating: 8.4,
    reason: "Recommended for Sci-Fi lovers",
    image:
      "/movies/beyond-earth.jpeg",
  },
  {
    title: "The Adventure",
    genre: "Adventure",
    rating: 8.2,
    reason: "You may enjoy this adventure",
    image:
      "/movies/the-adventure.jpg",
  },
];
function App() {
  const [user, setUser] = useState(() => {
  const savedUser = sessionStorage.getItem("user");
  return savedUser ? JSON.parse(savedUser) : null;
});
 const handleLogout = () => {
    sessionStorage.removeItem("user");
    setUser(null);
    window.location.href = "/";
  };
  const [currentMovie, setCurrentMovie] = useState(0);
const [location, setLocation] = useState("");
const [showNearbyTheatres, setShowNearbyTheatres] = useState(false);
const [preferredGenre, setPreferredGenre] = useState("All");
const getMostLikedGenre = () => {
  const history = JSON.parse(
  localStorage.getItem("movieHistory") || "[]"
);

  if (history.length === 0) {
    return "All";
  }

  const counts: Record<string, number> = {};

  history.forEach((genre: string) => {
    counts[genre] = (counts[genre] || 0) + 1;
  });

  return Object.keys(counts).reduce((a, b) =>
    counts[a] > counts[b] ? a : b
  );
};
const trackMovieInterest = (genre: string) => {
  const history = JSON.parse(
   localStorage.getItem("movieHistory") || "[]"
  );

  history.push(genre);

  localStorage.setItem(
  "movieHistory",
  JSON.stringify(history)
);

  setPreferredGenre(genre);
};
const likedGenre = getMostLikedGenre();

const activeGenre =
  preferredGenre === "All" ? likedGenre : preferredGenre;

const filteredRecommendations =
  activeGenre === "All"
    ? recommendedMovies
    : recommendedMovies.filter(
        (movie) => movie.genre === activeGenre
      );

  const nextMovie = () => {
    setCurrentMovie((prev) => (prev + 1) % movies.length);
  };

  const previousMovie = () => {
    setCurrentMovie((prev) => (prev - 1 + movies.length) % movies.length);
  };

  const movie = movies[currentMovie];
 if (window.location.pathname === "/login") {
  return <Login />;
}
if (window.location.pathname === "/my-bookings") {
  if (!user) {
    window.location.href = "/login";
    return null;
  }

  return (
    <>
      <Navbar user={user} onLogout={handleLogout} />
      <MyBookings />
    </>
  );
}

if (window.location.pathname === "/movies") {
  return (
    <>
      <Navbar user={user} onLogout={handleLogout} />
      <Movies />
    </>
  );
}
if (window.location.pathname === "/booking") {
  if (!user) {
    window.location.href = "/login";
    return null;
  }

  return <Booking />;
}
if (window.location.pathname === "/payment") {
  if (!user) {
    window.location.href = "/login";
    return null;
  }

  return <Payment />;
}
if (window.location.pathname === "/confirmation") {
  if (!user) {
    window.location.href = "/login";
    return null;
  }

  return <Confirmation />;
}

if (window.location.pathname === "/ticket") {
  return <Ticket />;
}
if (window.location.pathname === "/about") {
  return (
    <>
      <Navbar user={user} onLogout={handleLogout} />
      <About />
    </>
  );
}
if (window.location.pathname === "/contact") {
  return (
    <>
      <Navbar user={user} onLogout={handleLogout} />
      <Contact />
    </>
  );
}

  return (
    <div className="app">
      <Navbar user={user} onLogout={handleLogout} />

      {/* NAVBAR */}
     
      

     

      {/* HERO */}
      <section
        className="hero"
        id="home"
        style={{
          backgroundImage: `url(${movie.image})`,
        }}
      >
        <img
  src={movie.image}
  alt={movie.title}
  className="hero-poster"
/>

        <div className="hero-gradient"></div>

        <div className="hero-content">

          <div className="eyebrow">
            <span></span>
            NOW SHOWING
          </div>

          <h1>{movie.title}</h1>

          <p className="hero-subtitle">
            {movie.subtitle}
          </p>

          <div className="movie-meta">
            <span className="rating">
              ★ {movie.rating}
            </span>

            <span>{movie.genre}</span>

            <span>{movie.duration}</span>
          </div>

          <p className="hero-description">
            Experience cinema like never before. Discover the
            latest releases, choose your perfect seats and reserve
            your movie experience in seconds.
          </p>

          <div className="hero-buttons">
          <button
  className="primary-button"
  onClick={() => {
    const savedUser = sessionStorage.getItem("user");

    if (!savedUser) {
      sessionStorage.setItem(
        "loginRedirect",
        `/movies?movie=${encodeURIComponent(movie.title)}`
      );

      window.location.href = "/login";
      return;
    }

    window.location.href =
      `/movies?movie=${encodeURIComponent(movie.title)}`;
  }}
>
  Reserve Your Seat
  <span>→</span>
</button>

            <button className="secondary-button">
              ▶ Watch Trailer
            </button>
          </div>

        </div>

        {/* SLIDER CONTROLS */}
        <div className="slider-controls">

          <button onClick={previousMovie}>←</button>

          <div className="slider-number">
            <strong>0{currentMovie + 1}</strong>
            <span>/ 0{movies.length}</span>
          </div>

          <button onClick={nextMovie}>→</button>

        </div>

        {/* DOTS */}
        <div className="slider-dots">
          {movies.map((_, index) => (
            <button
              key={index}
              className={
                index === currentMovie ? "dot selected" : "dot"
              }
              onClick={() => setCurrentMovie(index)}
            ></button>
          ))}
        </div>
      </section>

     
   {/* LOCATION BAR */}
<section className="location-bar">

  <div className="location-title">
    <span className="location-icon">⌖</span>

    <div>
      <small>YOUR LOCATION</small>
      <h3>Find cinemas near you</h3>
    </div>
  </div>

  <div className="location-controls">

    <select
      value={location}
      onChange={(e) => setLocation(e.target.value)}
    >
      <option value="">Select your city</option>
      <option value="hyderabad">Hyderabad</option>
      <option value="bangalore">Bangalore</option>
      <option value="chennai">Chennai</option>
      <option value="mumbai">Mumbai</option>
      <option value="delhi">Delhi</option>
    </select>

    <button
      onClick={() => {
        if (!navigator.geolocation) {
          alert("Location is not supported by your browser.");
          return;
        }

        navigator.geolocation.getCurrentPosition(
          (position) => {
            console.log("Latitude:", position.coords.latitude);
            console.log("Longitude:", position.coords.longitude);

            setShowNearbyTheatres(true);
          },
          () => {
            alert("Please allow location access to find theatres near you.");
          }
        );
      }}
    >
      📍 Use My Location 
    </button>

    <button
  onClick={() => {
    window.location.href = "/movies";
  }}
>
  Find Shows →
</button>

  </div>

</section>
        {/* NEARBY THEATRES */}
{showNearbyTheatres && (
  <section className="nearby-theatres">

    <div className="section-heading">
      <div>
        <span className="section-label">
          LOCATION BASED
        </span>

        <h2>🎬 Theatres Near You</h2>

        <p>
          Cinemas available near your current location
        </p>
      </div>
    </div>

    <div className="theatre-grid">

      {nearbyTheatres.map((theatre) => (

        <div className="theatre-card" key={theatre.name}>

          <div className="theatre-icon">
            🎬
          </div>

          <div className="theatre-info">

            <h3>{theatre.name}</h3>

            <p>📍 {theatre.area}</p>

            <div className="theatre-meta">
              <span>⭐ {theatre.rating}</span>
              <span>📍 {theatre.distance}</span>
            </div>

           <button
  onClick={() => {
    window.location.href =
      `/movies?cinema=${encodeURIComponent(theatre.name)}`;
  }}
>
  View Shows →
</button>

          </div>

        </div>

      ))}

    </div>

  </section>
)}

      {/* NOW SHOWING */}
      <section className="movies-section" id="movies">

        <div className="section-heading">

          <div>
            <span className="section-label">
              CURATED FOR YOU
            </span>

            <h2>Now Showing</h2>
          </div>

          <button
  className="view-all"
  onClick={() => {
    window.location.href = "/movies";
  }}
>
  View All Movies →
</button>

        </div>

        <div className="movie-grid">

          {nowShowing.map((item, index) => (

            <div className="movie-card" key={index}>

              <div className="poster">

                <img
                  src={item.image}
                  alt={item.title}
                />

               <div className="poster-overlay">
  <button
    onClick={() => {
  sessionStorage.removeItem("bookingId");

  trackMovieInterest(item.genre);

  window.location.href =
    `/movies?movie=${encodeURIComponent(item.title)}`;
}}
  >
    Book Now
  </button>
</div>

              </div>

              <div className="movie-info">

                <h3>{item.title}</h3>
 

                <div>
                  <span>{item.genre}</span>
                  <span>★ 8.{index + 4}</span>
                </div>

              </div>

            </div>

          ))}

        </div>

      </section>
      {/* AI RECOMMENDATIONS */}
      <section className="recommendations-section">

        <div className="section-heading">
          <div>
            <span className="section-label">
              🤖 AI POWERED
            </span>

            <h2>Recommended For You</h2>
            <div className="recommendation-filters">
              {likedGenre !== "All" && (
  <p className="ai-message">
    🤖 Based on your activity, we think you'll enjoy{" "}
    <strong>{likedGenre}</strong> movies.
  </p>
)}
 {["All", "Action", "Drama", "Thriller", "Sci-Fi", "Adventure"].map(
    (genre) => (
      <button
        key={genre}
        className={
          preferredGenre === genre
            ? "recommendation-filter active"
            : "recommendation-filter"
        }
        onClick={() => setPreferredGenre(genre)}
      >
        {genre}
      </button>
    )
  )}
</div>

            <p>
              Smart movie suggestions based on your interests.
            </p>
          </div>
        </div>

        <div className="movie-grid">

         {filteredRecommendations.map((item, index) => (

            <div
              className="movie-card"
              key={index}
            >

              <div className="poster">

                <img
                  src={item.image}
                  alt={item.title}
                />

                <div className="poster-overlay">

                  <button
                   onClick={() => {
  trackMovieInterest(item.genre);

  window.location.href =
    `/movies?movie=${encodeURIComponent(item.title)}`;
}}
                  >
                    Book Now
                  </button>

                </div>

              </div>

              <div className="movie-info">

                <h3>{item.title}</h3>
<p className="recommendation-rating">
  ⭐ {item.rating}/10
</p>
                <div>
                  <span>{item.genre}</span>
                </div>

                <small className="recommendation-reason">
                  ✨ {item.reason}
                </small>

              </div>

            </div>

          ))}

        </div>

      </section>
      
          {/* FOOTER */}
      <footer>
        <div>
          <strong>🎬 CineReserve</strong>
          <p>Your movie experience, reserved.</p>
        </div>

        <p>© 2026 CineReserve. All rights reserved.</p>
      </footer>

      <Chatbot />

    </div>
  );
}

export default App;