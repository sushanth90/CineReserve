import { useEffect, useState } from "react";
import { API_BASE_URL } from "./api";
import { getAssetUrl, getRouteParams, navigate } from "./nav";

const cinemaLocations: Record<string, string> = {
  "AMB Cinemas": "Gachibowli, Hyderabad",
  "PVR Atrium": "Gachibowli, Hyderabad",
  "PVR Preston": "Gachibowli, Hyderabad",
  "PVR Inorbit": "Madhapur, Hyderabad",
  "ALLU Cinemas": "Kukatpally, Hyderabad",
};

const rawMovies = [
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
    title: "Interstellar",
    genre: "Sci-Fi",
    rating: "8.7",
    duration: "2h 49m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["AMB Cinemas", "PVR Atrium"],
    image: "/movies/interstellar.jpg",
  },
  {
    title: "The Dark Knight",
    genre: "Action",
    rating: "9.0",
    duration: "2h 32m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["PVR Preston", "PVR Inorbit"],
    image: "/movies/the-dark-knight.jpg",
  },
  {
    title: "Cinema Night",
    genre: "Drama",
    rating: "8.5",
    duration: "2h 10m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["AMB Cinemas", "PVR Atrium"],
    image: "/movies/cinema-night.jpeg",
  },
  {
    title: "The Last Journey",
    genre: "Drama",
    rating: "8.3",
    duration: "2h 05m",
    languages: ["Hindi", "Telugu"],
    cinemas: ["AMB Cinemas", "ALLU Cinemas"],
    image: "/movies/the-last-journey.jpeg",
  },
  {
    title: "Midnight City",
    genre: "Thriller",
    rating: "8.5",
    duration: "2h 10m",
    languages: ["Hindi", "Telugu"],
    cinemas: ["AMB Cinemas", "ALLU Cinemas"],
    image: "/movies/midnight-city.jpg",
  },
  {
    title: "Beyond Earth",
    genre: "Sci-Fi",
    rating: "8.6",
    duration: "2h 20m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["PVR Atrium", "PVR Inorbit"],
    image: "/movies/beyond-earth.jpeg",
  },
  {
    title: "The Adventure",
    genre: "Adventure",
    rating: "8.4",
    duration: "2h 15m",
    languages: ["English", "Hindi", "Telugu"],
    cinemas: ["ALLU Cinemas", "PVR Preston"],
    image: "/movies/the-adventure.jpg",
  },
];
const movies = rawMovies.map((m) => ({ ...m, image: getAssetUrl(m.image) }));

function Movies() {
  const params = getRouteParams();
  const movieFromHome = params.get("movie");
  const cinemaFromHome = params.get("cinema");

const [dbMovies, setDbMovies] = useState<any[]>([]);
const [dbShows, setDbShows] = useState<any[]>([]);
const [dbCinemas, setDbCinemas] = useState<any[]>([]);

const selectedMovieFromHome = dbMovies.find(
  (movie) => movie.title === movieFromHome
);
  const [selectedGenre, setSelectedGenre] = useState("All");
  const [selectedLanguage, setSelectedLanguage] = useState("All");

 const [selectedCinema, setSelectedCinema] = useState(
  cinemaFromHome || "All"
);

const cinemaFallbackMap: Record<string, number> = {
  "AMB Cinemas": 2,
  "PVR Atrium": 3,
  "PVR Preston": 4,
  "PVR Inorbit": 5,
  "ALLU Cinemas": 6,
};

const getCinemaId = (name: string): number | undefined => {
  const cinemaObj = dbCinemas.find((c) => c.name === name);
  return cinemaObj?.id ?? cinemaFallbackMap[name];
};

useEffect(() => {
  fetch(`${API_BASE_URL}/api/movies/`)
    .then((response) => response.json())
    .then((data) => {
      console.log("Movies from backend:", data);
      if (Array.isArray(data)) {
        setDbMovies(data.map((m: any) => ({ ...m, image: getAssetUrl(m.image) })));
      }
    })
    .catch((error) => {
      console.error("Error fetching movies:", error);
    });

  fetch(`${API_BASE_URL}/api/shows/`)
    .then((response) => response.json())
    .then((data) => {
      console.log("Shows from backend:", data);
      setDbShows(data);
    })
    .catch((error) => {
      console.error("Error fetching shows:", error);
    });

  fetch(`${API_BASE_URL}/api/cinemas/`)
    .then((response) => response.json())
    .then((data) => {
      console.log("Cinemas from backend:", data);
      setDbCinemas(data);
    })
    .catch((error) => {
      console.error("Error fetching cinemas:", error);
    });
}, []);
  const [selectedDate, setSelectedDate] = useState("");
  const [selectedShowtime, setSelectedShowtime] = useState("");
 const [selectedFormat, setSelectedFormat] = useState("");

  const formats = [
  ...new Set(
    dbShows
      .filter((show) => {
        if (
          selectedMovieFromHome &&
          show.movieId !== selectedMovieFromHome.id
        ) {
          return false;
        }

        const targetCinemaId = getCinemaId(selectedCinema);
        if (
          selectedCinema !== "All" &&
          show.cinemaId !== targetCinemaId
        ) {
          return false;
        }

        if (
          selectedDate &&
          show.date !== selectedDate
        ) {
          return false;
        }

        return true;
      })
      .map((show) => show.format)
  ),
];

const showtimes = [
  ...new Set(
    dbShows
      .filter((show) => {
        if (
          selectedMovieFromHome &&
          show.movieId !== selectedMovieFromHome.id
        ) {
          return false;
        }

        const targetCinemaId = getCinemaId(selectedCinema);
        if (
          selectedCinema !== "All" &&
          show.cinemaId !== targetCinemaId
        ) {
          return false;
        }
        if (
          selectedDate &&
          show.date !== selectedDate
        ) {
          return false;
        }

        return true;
      })
      .map((show) => show.time)
  ),
];

  const genres = [
    "All",
    "Action",
    "Adventure",
    "Drama",
    "Sci-Fi",
    "Thriller",
  ];

  const languages = [
    "All",
    "Telugu",
    "Hindi",
    "English",
    "Tamil",
    "Malayalam",
    "Kannada",
  ];

  const cinemas = [
    "All",
    "AMB Cinemas",
    "PVR Atrium",
    "PVR Preston",
    "PVR Inorbit",
    "ALLU Cinemas",
  ];

const movieOrder = [
  "Doctor Strange",
  "Iron Man",
  "Thor: Ragnarok",
  "Spider-Man: No Way Home",
  "Black Panther",
  "Guardians of the Galaxy",
  "Ant-Man",
  "Avengers: Infinity War",
  "Avengers: Endgame",
  "Interstellar",
  "The Dark Knight",
  "Cinema Night",
  "The Last Journey",
  "Midnight City",
  "Beyond Earth",
  "The Adventure",
];

const filteredMovies = dbMovies
  .filter((movie) => {
    const movieMatch =
      !movieFromHome || movie.title === movieFromHome;

    const genreMatch =
      selectedGenre === "All" || movie.genre === selectedGenre;

    const languageMatch =
      selectedLanguage === "All" ||
      movie.languages.includes(selectedLanguage);
const cinemaMatch =
  selectedCinema === "All" ||
  (Array.isArray(movie.cinemas) &&
    movie.cinemas.includes(selectedCinema));

    return (
      movieMatch &&
      genreMatch &&
      languageMatch &&
      cinemaMatch
    );
  })
  .sort(
    (a, b) =>
      movieOrder.indexOf(a.title) -
      movieOrder.indexOf(b.title)
  );

 const handleReserveSeat = (movie: (typeof movies)[number]) => {
  // 1. Check Genre
  if (selectedGenre === "All") {
    alert("Please select a genre.");
    return;
  }

  // 2. Check Language
  if (selectedLanguage === "All") {
    alert("Please select a language.");
    return;
  }

  // 3. Check Cinema
  if (selectedCinema === "All") {
    alert("Please select a cinema.");
    return;
  }

  // 4. Check Date
  if (!selectedDate) {
    alert("Please select a date.");
    return;
  }

  // 5. Check Showtime
  if (!selectedShowtime) {
    alert("Please select a showtime.");
    return;
  }

 // 6. Record movie interest for AI recommendations
const history = JSON.parse(
  localStorage.getItem("movieHistory") || "[]"
);

history.push(movie.genre);

localStorage.setItem(
  "movieHistory",
  JSON.stringify(history)
);

// 7. All required selections are complete
const location = cinemaLocations[selectedCinema];

  navigate("/booking", {
    movie: movie.title,
    language: selectedLanguage,
    cinema: selectedCinema,
    date: selectedDate,
    time: selectedShowtime,
    format: selectedFormat,
    location: location || "",
  });
};

  return (
    <section className="movies-page">

      <div className="movies-header">
        <div>
          <span className="section-label">
            EXPLORE OUR COLLECTION
          </span>

          <h1>Movies</h1>

          <p>
            Discover movies, explore genres and reserve your
            perfect cinema experience.
          </p>
        </div>
      </div>

      <div className="filter-section">

        <span className="filter-title">GENRE</span>

        <div className="genre-filters">
         {genres.map((genre) => {
  const genreAvailable =
    !selectedMovieFromHome ||
    genre === "All" ||
    selectedMovieFromHome.genre === genre;

  return (
    <button
      key={genre}
      disabled={!genreAvailable}
      className={
        selectedGenre === genre
          ? "filter active"
          : !genreAvailable
          ? "filter disabled-option"
          : "filter"
      }
      onClick={() => setSelectedGenre(genre)}
    >
      {genre}
    </button>
  );
})}
        </div>

        <span className="filter-title">LANGUAGE</span>

        <div className="genre-filters language-filters">
         {languages.map((language) => {
  const languageAvailable =
    !selectedMovieFromHome ||
    language === "All" ||
    selectedMovieFromHome.languages.includes(language);

  return (
    <button
      key={language}
      disabled={!languageAvailable}
      className={
        selectedLanguage === language
          ? "filter active"
          : !languageAvailable
          ? "filter disabled-option"
          : "filter"
      }
      onClick={() => setSelectedLanguage(language)}
    >
      {language}
    </button>
  );
})}
        </div>

        <span className="filter-title">CINEMA</span>

        <div className="genre-filters cinema-filters">
      {cinemas.map((cinema) => {
  const cinemaAvailable =
    !selectedMovieFromHome ||
    cinema === "All" ||
    selectedMovieFromHome.cinemas.includes(cinema);

  return (
    <button
      key={cinema}
      disabled={!cinemaAvailable}
      className={
        selectedCinema === cinema
          ? "filter active"
          : !cinemaAvailable
          ? "filter disabled-option"
          : "filter"
      }
      onClick={() => setSelectedCinema(cinema)}
    >
      {cinema}
    </button>
  );
})}
        </div>

        <div className="date-section">
          <span className="filter-title">DATE</span>

  <input
  type="date"
  value={selectedDate}
  min="2026-10-10"
  max="2026-10-23"
  onChange={(e) => {
    setSelectedDate(e.target.value);
  }}
/>
        </div>

        <div className="showtime-section">
          <span className="filter-title">
            SHOWTIME
          </span>

          <div className="showtime-filters">
            {showtimes.map((time) => (
              <button
                key={time}
                className={
                  selectedShowtime === time
                    ? "showtime-button active"
                    : "showtime-button"
                }
                onClick={() =>
                  setSelectedShowtime(time)
                }
              >
                {time}
              </button>
            ))}
          </div>
        </div>

        <div className="format-section">
          <span className="filter-title">
            FORMAT
          </span>

          <div className="format-filters">
            {formats.map((format) => (
              <button
                key={format}
                className={
                  selectedFormat === format
                    ? "format-button active"
                    : "format-button"
                }
                onClick={() =>
                  setSelectedFormat(format)
                }
              >
                {format}
              </button>
            ))}
          </div>
        </div>
      </div>

      <div className="movies-grid">

        {filteredMovies.map((movie) => (

          <div
            className="full-movie-card"
            key={movie.title}
          >

            <div className="full-poster">

              <img
                src={movie.image}
                alt={movie.title}
              />

              <div className="movie-rating">
                ★ {movie.rating}
              </div>

              <div className="movie-hover">

                <button
                  onClick={() =>
                    handleReserveSeat(movie)
                  }
                >
                  Reserve Seat →
                </button>

              </div>

            </div>

            <div className="full-movie-info">

              <h2>{movie.title}</h2>

              <div className="movie-details">
                <span>{movie.genre}</span>

                <span>{movie.duration}</span>

                <span>
                  {movie.languages.join(" • ")}
                </span>
              </div>

              <button
                className="book-button"
                onClick={() =>
                  handleReserveSeat(movie)
                }
              >
                Reserve Seat →
              </button>

            </div>

          </div>

        ))}

      </div>

    </section>
  );
}

export default Movies;