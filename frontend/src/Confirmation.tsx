import { QRCodeSVG } from "qrcode.react";
function Confirmation() {
  const params = new URLSearchParams(window.location.search);

  const movie = params.get("movie") || "Movie";
  const cinema = params.get("cinema") || "Cinema";
  const date = params.get("date") || "Not selected";
  const time = params.get("time") || "Not selected";
  const seats = params.get("seats") || "No seats";
  const format = params.get("format") || "2D";
  const foodTotal = Number(params.get("foodTotal") || 0);
  const totalAmount = Number(params.get("total") || 0);
  const location = params.get("location") || "Not selected";

  const bookingId =
  params.get("bookingId") ||
  sessionStorage.getItem("bookingId") ||
  "CR" + Math.floor(100000 + Math.random() * 900000);

sessionStorage.setItem("bookingId", bookingId);
  return (
    <div className="confirmation-page">

      <div className="confirmation-card">

        <div className="success-icon">
          ✓
        </div>

        <span className="section-label">
          CINERESERVE
        </span>

        <h1>Booking Confirmed!</h1>

        <p className="confirmation-message">
          Your movie tickets have been successfully booked.
        </p>

        <div className="ticket">

          <div className="ticket-movie">
            <span>MOVIE</span>
            <h2>{movie}</h2>
          </div>

          <div className="ticket-details">

            <div>
              <span>🏢 Cinema</span>
              <strong>{cinema}</strong>
            </div>

            <div>
              <span>📍 Location</span>
              <strong>{location}</strong>
            </div>

            <div>
              <span>📅 Date</span>
              <strong>{date}</strong>
            </div>

            <div>
              <span>🕐 Showtime</span>
              <strong>{time}</strong>
            </div>

            <div>
              <span>💺 Seats</span>
              <strong>{seats}</strong>
            </div>

            <div>
              <span>🎞️ Format</span>
              <strong>{format}</strong>
            </div>

            <div>
              <span>🍿 Food & Beverages</span>
              <strong>₹{foodTotal}</strong>
            </div>

            <div>
              <span>💳 Amount Paid</span>
              <strong>₹{totalAmount}</strong>
            </div>

          </div>

          <div className="booking-id">
            <span>BOOKING ID</span>
            <strong>{bookingId}</strong>
          </div>
<div className="qr-placeholder">
 <QRCodeSVG

value={`${window.location.origin}/ticket?bookingId=${encodeURIComponent(bookingId)}&movie=${encodeURIComponent(movie)}&cinema=${encodeURIComponent(cinema)}&location=${encodeURIComponent(location)}&date=${encodeURIComponent(date)}&time=${encodeURIComponent(time)}&seats=${encodeURIComponent(seats)}&format=${encodeURIComponent(format)}&total=${encodeURIComponent(totalAmount)}`}
  size={200}
  level="H"
  marginSize={2}
  bgColor="#ffffff"
  fgColor="#000000"
/>

  <span>Scan for Ticket Details</span>
</div>

        </div>

        <button
          className="home-button"
          onClick={() => {
            window.location.href = "/";
          }}
        >
          Back to Home →
        </button>

      </div>

    </div>
  );
}

export default Confirmation;