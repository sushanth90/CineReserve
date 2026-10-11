import { useEffect, useState } from "react";
import { API_BASE_URL } from "./api";

type TicketDetails = {
  bookingId: string;
  movieName: string | null;
  cinemaName: string | null;
  cinemaLocation: string | null;
  showDate: string | null;
  showTime: string | null;
  format?: string | null;
  seatNumber: string;
  totalAmount: number;
  status: string;
};

function Ticket() {
  const params = new URLSearchParams(window.location.search);
  const bookingId = params.get("bookingId") || "";

  const [status, setStatus] = useState("Loading ticket details...");
  const [verified, setVerified] = useState(false);
  const [ticket, setTicket] = useState<TicketDetails | null>(null);

  useEffect(() => {
    if (!bookingId) {
      setStatus("Invalid ticket: booking ID is missing.");
      return;
    }

    let cancelled = false;

    async function loadTicket() {
      try {
        const response = await fetch(
          `${API_BASE_URL}/api/bookings/verify/${encodeURIComponent(bookingId)}`
        );

        const verifyData = await response.json();

        if (!response.ok || !verifyData.verified) {
          throw new Error(
            verifyData.message || "Ticket verification failed."
          );
        }

        if (cancelled) return;

        setTicket({
          bookingId: verifyData.bookingId || bookingId,
          movieName: verifyData.movieName || "Movie details unavailable",
          cinemaName: verifyData.cinemaName || "Cinema details unavailable",
          cinemaLocation: verifyData.cinemaLocation || "Location unavailable",
          showDate: verifyData.showDate || null,
          showTime: verifyData.showTime || null,
          format: verifyData.format || "2D",
          seatNumber: verifyData.seatNumbers || verifyData.seatNumber || "Unknown",
          totalAmount: Number(verifyData.totalAmount || 0),
          status: verifyData.status || "CONFIRMED",
        });
        setVerified(true);
        setStatus("Booking verified successfully.");
      } catch (error) {
        if (cancelled) return;

        setVerified(false);
        setStatus(
          error instanceof Error
            ? error.message
            : "Unable to load ticket details."
        );
      }
    }

    loadTicket();

    return () => {
      cancelled = true;
    };
  }, [bookingId]);

  const displayDate = (value: string | null | undefined) => {
    if (!value) return "Not available";

    const parsed = new Date(`${value.slice(0, 10)}T00:00:00`);

    return Number.isNaN(parsed.getTime())
      ? value
      : parsed.toLocaleDateString("en-IN", {
          day: "2-digit",
          month: "short",
          year: "numeric",
        });
  };

  return (
    <div className="ticket-page">
      <div className="ticket-card">
        <div className="success-icon">{verified ? "✓" : "!"}</div>

        <span className="section-label">CINERESERVE</span>
        <h1>Digital Movie Ticket</h1>

        <p>
          <strong>{status}</strong>
        </p>

        {verified && ticket && (
          <div className="ticket-info">
            <h2>{ticket.movieName || "Movie details unavailable"}</h2>
            <p>🏢 {ticket.cinemaName || "Cinema details unavailable"}</p>
            <p>📍 {ticket.cinemaLocation || "Location unavailable"}</p>
            <p>📅 {displayDate(ticket.showDate)}</p>
            <p>🕐 {ticket.showTime || "Not available"}</p>
            <p>💺 {ticket.seatNumber || "Unknown"}</p>
            <hr />
            <p>
              🎟️ Booking ID: <strong>{bookingId}</strong>
            </p>
            <p>
              💳 Amount Paid:{" "}
              <strong>
                ₹{Number(ticket.totalAmount || 0).toFixed(2)}
              </strong>
            </p>
            <p>
              Status: <strong>{ticket.status}</strong>
            </p>
            <h3>✓ Ticket Verified</h3>
          </div>
        )}
      </div>
    </div>
  );
}

export default Ticket;