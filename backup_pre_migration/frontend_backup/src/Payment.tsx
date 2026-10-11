import { useState } from "react";

function Payment() {
  const params = new URLSearchParams(window.location.search);

  const movie = params.get("movie") || "Movie";
  const cinema = params.get("cinema") || "Cinema";
  const date = params.get("date") || "Not selected";
  const time = params.get("time") || "Not selected";
  const seats = params.get("seats") || "No seats";
  const format = params.get("format") || "2D";
  const foodTotal = Number(params.get("foodTotal") || 0);
  const location = params.get("location") || "Not selected";

  const selectedSeats = seats === "No seats" ? [] : seats.split(",");

  const ticketPrice = 250;
  const ticketTotal = selectedSeats.length * ticketPrice;
  const convenienceFee = 40;
 const totalAmount = ticketTotal + foodTotal + convenienceFee;

  const [paymentMethod, setPaymentMethod] = useState("card");

  const [cardNumber, setCardNumber] = useState("");
  const [expiry, setExpiry] = useState("");
  const [cvv, setCvv] = useState("");
const [upiId, setUpiId] = useState("");
const handlePayment = async (e: React.FormEvent) => {
  if (paymentMethod === "card") {
    if (!cardNumber || !expiry || !cvv) {
      alert("Please enter all card details.");
      return;
    }
    if (cardNumber.replace(/\s/g, "").length < 16) {
  alert("Please enter a valid 16-digit card number.");
  return;
}
if (!/^\d{2}\/\d{2}$/.test(expiry)) {
  alert("Please enter expiry in MM/YY format.");
  return;
}
if (!/^\d{3,4}$/.test(cvv)) {
  alert("Please enter a valid CVV.");
  return;
}
  }
  if (paymentMethod === "upi") {
  if (!upiId) {
    alert("Please enter your UPI ID.");
    return;
  }
}

const savedUser = sessionStorage.getItem("user");

if (!savedUser) {
  sessionStorage.setItem("loginRedirect", window.location.pathname + window.location.search);
  window.location.href = "/login";
  return;
}

const loggedInUser = JSON.parse(savedUser);

const bookingId =
  "CR" + Math.floor(100000 + Math.random() * 900000);

try {
  const response = await fetch("http://localhost:5000/api/bookings", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
 body: JSON.stringify({
  bookingId,
  userId: loggedInUser.id,
  movie,
  cinema,
  date,
  time,
  seats: selectedSeats,
  totalAmount,
}),
  });

  const result = await response.json();

  if (!response.ok) {
    alert(result.message || "Booking failed.");
    return;
  }

 window.location.href =
  `/confirmation?bookingId=${encodeURIComponent(bookingId)}` +
  `&movie=${encodeURIComponent(movie)}` +
  `&cinema=${encodeURIComponent(cinema)}` +
  `&date=${encodeURIComponent(date)}` +
  `&time=${encodeURIComponent(time)}` +
  `&seats=${encodeURIComponent(seats)}` +
  `&format=${encodeURIComponent(format)}` +
  `&foodTotal=${encodeURIComponent(foodTotal)}` +
  `&total=${encodeURIComponent(totalAmount)}` +
  `&location=${encodeURIComponent(location)}`;
} catch (error) {
  console.error("Booking error:", error);
  alert("Unable to connect to the booking server.");
}
};

  return (
    <div className="payment-page">

      <div className="payment-header">
        <span className="section-label">CINERESERVE</span>

        <h1>Complete Your Payment</h1>

        <p>
          Securely complete your booking and enjoy your movie.
        </p>
      </div>

      <div className="payment-container">

        {/* BOOKING SUMMARY */}

        <div className="payment-summary">

          <h2>Booking Summary</h2>

          <div className="summary-movie">
            <span>MOVIE</span>
            <strong>{movie}</strong>
          </div>

          <div className="summary-row">
            <span>🏢 Cinema</span>
            <strong>{cinema}</strong>
          </div>

          <div className="summary-row">
            <span>📅 Date</span>
            <strong>{date}</strong>
          </div>

          <div className="summary-row">
            <span>🕐 Showtime</span>
            <strong>{time}</strong>
          </div>

          <div className="summary-row">
            <span>🎞️ Format</span>
            <strong>{format}</strong>
          </div>

          <div className="summary-row">
            <span>💺 Seats</span>
            <strong>{seats}</strong>
          </div>

          <hr />

          <div className="price-row">
            <span>
              Tickets ({selectedSeats.length})
            </span>

            <strong>₹{ticketTotal}</strong>
          </div>
          <div className="price-row">
  <span>Food & Beverages</span>
  <strong>₹{foodTotal}</strong>
</div>

          <div className="price-row">
            <span>Convenience Fee</span>

            <strong>₹{convenienceFee}</strong>
          </div>

          <div className="total-row">
            <span>Total Amount</span>

            <strong>₹{totalAmount}</strong>
          </div>

        </div>


        {/* PAYMENT */}

        <div className="payment-box">

          <h2>Payment Method</h2>

          <div className="payment-methods">

            <button
              className={
                paymentMethod === "card"
                  ? "payment-method active"
                  : "payment-method"
              }
              onClick={() => setPaymentMethod("card")}
            >
              💳 Card
            </button>

            <button
              className={
                paymentMethod === "upi"
                  ? "payment-method active"
                  : "payment-method"
              }
              onClick={() => setPaymentMethod("upi")}
            >
              📱 UPI
            </button>

          </div>


          {paymentMethod === "card" && (
            <div className="card-form">

              <label>Card Number</label>

             <input
  type="text"
  inputMode="numeric"
  placeholder="1234 5678 9012 3456"
  value={cardNumber}
  maxLength={19}
  onChange={(e) => {
    const value = e.target.value
      .replace(/\D/g, "")
      .substring(0, 16);

    const formatted = value.match(/.{1,4}/g)?.join(" ") || "";

    setCardNumber(formatted);
  }}
/>

              <div className="card-row">

                <div>
                  <label>Expiry Date</label>

                  <input
  type="text"
  inputMode="numeric"
  placeholder="MM/YY"
  value={expiry}
  maxLength={5}
  onChange={(e) => {
    let value = e.target.value.replace(/\D/g, "");

    if (value.length > 2) {
      value =
        value.substring(0, 2) + "/" + value.substring(2, 4);
    }

    setExpiry(value);
  }}
/>
                </div>

                <div>
                  <label>CVV</label>

                 <input
  type="password"
  inputMode="numeric"
  placeholder="123"
  value={cvv}
  maxLength={4}
  onChange={(e) => {
    const value = e.target.value.replace(/\D/g, "");
    setCvv(value);
  }}
/>
                </div>

              </div>

            </div>
          )}


          {paymentMethod === "upi" && (
            <div className="upi-form">

              <label>UPI ID</label>

              <input
  type="text"
  placeholder="example@upi"
  value={upiId}
  onChange={(e) => setUpiId(e.target.value)}
/>

            </div>
          )}


          <button
            className="pay-button"
            onClick={handlePayment}
          >
            Pay ₹{totalAmount} →
          </button>

          <p className="secure-payment">
            🔒 Secure payment powered by CineReserve
          </p>

        </div>

      </div>

    </div>
  );
}

export default Payment;