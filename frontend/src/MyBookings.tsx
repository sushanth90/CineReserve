import { useEffect, useState } from "react";
import "./MyBookings.css";
import { API_BASE_URL, getAuthHeaders } from "./api";

type Booking = {
  id: number;
  bookingId: string;
  movieId: number;
  cinemaId: number;
  showId: number;
  seatId: number;
  totalAmount: number;
  status: string;
  userId: number;
  seatNumber?: string;

  // These details should be returned by the backend
  movieName?: string;
  cinemaName?: string;
  showDate?: string;
  showTime?: string;
};

export default function MyBookings() {
  const [bookings, setBookings] = useState<Booking[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    const savedUser = sessionStorage.getItem("user");

    if (!savedUser) {
      setError("Please log in to view your bookings.");
      setLoading(false);
      return;
    }

    try {
      const user = JSON.parse(savedUser);

      if (!user.id) {
        setError("Please log in again to view your bookings.");
        setLoading(false);
        return;
      }

      fetch(`${API_BASE_URL}/api/bookings/my/${user.id}`, {
        headers: getAuthHeaders(),
      })
        .then((response) => {
          if (!response.ok) {
            throw new Error("Could not load bookings.");
          }
          return response.json();
        })
        .then((data: Booking[]) => {
          setBookings(data);
          setLoading(false);
        })
        .catch(() => {
          setError("Unable to load bookings. Please try again.");
          setLoading(false);
        });
    } catch {
      setError("Please log in again to view your bookings.");
      setLoading(false);
    }
  }, []);

  if (loading) {
    return (
      <main className="my-bookings">
        <p className="bookings-message">Loading your bookings...</p>
      </main>
    );
  }

  if (error) {
    return (
      <main className="my-bookings">
        <h1>My Bookings</h1>
        <p className="bookings-error">{error}</p>
      </main>
    );
  }

  const groupedBookings = Object.values(
    bookings.reduce((groups, booking) => {
      const baseBookingNumber =
        booking.bookingId?.replace(/-[A-Za-z0-9]+$/, "") ||
        booking.bookingId ||
        String(booking.id);

      if (!groups[baseBookingNumber]) {
        groups[baseBookingNumber] = [];
      }

      groups[baseBookingNumber].push(booking);
      return groups;
    }, {} as Record<string, Booking[]>)
  );

  return (
    <main className="my-bookings">
      <header className="bookings-header">
        <p className="bookings-eyebrow">CINERESERVE</p>
        <h1>My Bookings</h1>
        <p className="bookings-subtitle">
          Your movie tickets, all in one place.
        </p>
      </header>

      {groupedBookings.length === 0 ? (
        <section className="empty-bookings">
          <div className="empty-bookings-icon">🎬</div>
          <h2>No bookings yet</h2>
          <p>
            Your movie bookings will appear here after you book a ticket.
          </p>
          <a href="/movies" className="browse-movies-button">
            Browse Movies
          </a>
        </section>
      ) : (
        <section className="booking-list">
          {groupedBookings.map((group) => {
            const booking = group[0];
            const bookingNumber =
              booking.bookingId || String(booking.id);

            const seats = group
              .map((item) => item.seatNumber || "Unknown")
              .join(", ");

            const isConfirmed =
              booking.status?.toUpperCase() === "CONFIRMED";

            return (
              <article
                className="booking-card"
                key={bookingNumber}
              >
                <div className="booking-card-top">
                  <div>
                    <span className="booking-reference-label">
                      BOOKING REFERENCE
                    </span>
                    <h2>{bookingNumber}</h2>
                  </div>

                  <span
                    className={`booking-status ${
                      isConfirmed ? "confirmed" : "cancelled"
                    }`}
                  >
                    {booking.status || "UNKNOWN"}
                  </span>
                </div>

                <div className="booking-divider" />

                <div className="booking-details">
                  <div className="booking-detail">
                    <span>Movie</span>
                    <strong>
                      {booking.movieName || `Movie #${booking.movieId}`}
                    </strong>
                  </div>

                  <div className="booking-detail">
                    <span>Cinema</span>
                    <strong>
                      {booking.cinemaName ||
                        `Cinema #${booking.cinemaId}`}
                    </strong>
                  </div>

                  <div className="booking-detail">
                    <span>Date</span>
                    <strong>
                      {booking.showDate
                        ? new Date(
                            `${booking.showDate}T00:00:00`
                          ).toLocaleDateString("en-IN", {
                            day: "2-digit",
                            month: "short",
                            year: "numeric",
                          })
                        : "Not available"}
                    </strong>
                  </div>

                  <div className="booking-detail">
                    <span>Show time</span>
                    <strong>{booking.showTime || "Not available"}</strong>
                  </div>

                  <div className="booking-detail">
                    <span>Seats</span>
                    <strong>{seats}</strong>
                  </div>

                  <div className="booking-detail">
                    <span>Total amount</span>
                    <strong className="booking-amount">
                      ₹{Number(booking.totalAmount || 0).toFixed(2)}
                    </strong>
                  </div>
                </div>

                <div className="booking-card-footer">
                  <span>Enjoy your movie!</span>
                  <a
                    href={`/ticket?bookingId=${encodeURIComponent(
                      bookingNumber
                    )}`}
                    className="view-ticket-button"
                  >
                    View Ticket
                  </a>
                </div>
              </article>
            );
          })}
        </section>
      )}
    </main>
  );
}