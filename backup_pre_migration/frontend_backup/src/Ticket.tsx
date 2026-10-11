import { useEffect, useState } from "react";

type TicketDetails = {
  bookingId: string;
  movieName: string | null;
  cinemaName: string | null;
  showDate: string | null;
  showTime: string | null;
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
        const baseUrl = `http://${window.location.hostname}:5000/api/bookings`;

        const [verifyResponse, bookingsResponse] = await Promise.all([
          fetch(
            `${baseUrl}/verify/${encodeURIComponent(bookingId)}`
          ),
          fetch(`${baseUrl}/my/${getUserId()}`),
        ]);

        const verifyData = await verifyResponse.json();

        if (!verifyResponse.ok || !verifyData.verified) {
          throw new Error(
            verifyData.message || "Ticket verification failed."
          );
        }

        if (!bookingsResponse.ok) {
          throw new Error("Could not load saved booking details.");
        }

        const bookings: TicketDetails[] = await bookingsResponse.json();

        const matchingTicket = bookings.find(
          (item) => item.bookingId === bookingId
        );

        if (!matchingTicket) {
          throw new Error(
            "Booking details were not found for this logged-in user."
          );
        }

        if (cancelled) return;

        setTicket(matchingTicket);
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

    function getUserId() {
      try {
        const savedUser = sessionStorage.getItem("user");
        if (!savedUser) return "0";

        const user = JSON.parse(savedUser);
        return encodeURIComponent(String(user.id || 0));
      } catch {
        return "0";
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
            <p>📍 Cinema location: Check cinema details</p>
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