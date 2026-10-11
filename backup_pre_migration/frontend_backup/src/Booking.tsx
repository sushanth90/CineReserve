import { useEffect, useState } from "react";

const rows = ["A", "B", "C", "D", "E", "F", "G"];

function Booking() {
  const [selectedSeats, setSelectedSeats] = useState<string[]>([]);
  const [occupiedSeats, setOccupiedSeats] = useState<string[]>([]);
  const [selectedFood, setSelectedFood] = useState<
  { name: string; price: number }[]
>([]);
  const params = new URLSearchParams(window.location.search);

const bookingDate = params.get("date") || "Not selected";
const bookingTime = params.get("time") || "Not selected";
const bookingMovie = params.get("movie") || "Not selected";
const bookingLanguage = params.get("language") || "Not selected";
const bookingCinema = params.get("cinema") || "Not selected";
const bookingFormat = params.get("format") || "Not selected";
const bookingLocation =
  params.get("location") || "Not selected";

const [selectedTime, setSelectedTime] = useState(bookingTime);
useEffect(() => {
  const fetchOccupiedSeats = async () => {
    try {
      const response = await fetch(
        `http://localhost:5000/api/bookings/occupied` +
          `?movie=${encodeURIComponent(bookingMovie)}` +
          `&cinema=${encodeURIComponent(bookingCinema)}` +
          `&date=${encodeURIComponent(bookingDate)}` +
          `&time=${encodeURIComponent(bookingTime)}`
      );

      const data = await response.json();

      if (response.ok) {
        setOccupiedSeats(data.occupiedSeats || []);
      }
    } catch (error) {
      console.error("Error fetching occupied seats:", error);
    }
  };

  fetchOccupiedSeats();
}, [bookingMovie, bookingCinema, bookingDate, bookingTime]);

 

  const seatsPerRow = 8;
  const foodItems = [
  {
    name: "Classic Popcorn",
    price: 180,
    icon: "🍿",
  },
  {
    name: "Coke",
    price: 120,
    icon: "🥤",
  },
  {
    name: "Chocolate",
    price: 100,
    icon: "🍫",
  },
  {
    name: "Popcorn + Coke Combo",
    price: 250,
    icon: "🍿🥤",
  },
];

  const toggleSeat = (seat: string) => {
    if (occupiedSeats.includes(seat)) {
      return;
    }

    setSelectedSeats((current) =>
      current.includes(seat)
        ? current.filter((item) => item !== seat)
        : [...current, seat]
    );
  };

  const ticketPrice = 250;
  const totalPrice = selectedSeats.length * ticketPrice;
  const foodTotal = selectedFood.reduce(
  (total, item) => total + item.price,
  0
);

const grandTotal = totalPrice + foodTotal;

  return (
    <div className="booking-page">

      <div className="booking-header">
        <span className="section-label">CINERESERVE</span>
        <h1>Select Your Seats</h1>
        <p>
          Choose your preferred seats and enjoy your movie experience.
        </p>
      </div>

      {/* MOVIE INFORMATION */}
      <div className="booking-movie">
        <div>
          <span>NOW BOOKING</span>
         <h2 style={{ color: "white" }}>{bookingMovie}</h2>
            <p>
               {bookingFormat} • {bookingLanguage} • {bookingDate}
             </p>
<p>
  📍 {bookingLocation}
</p>
               <p>
               🏢 {bookingCinema} • 🕐 {bookingTime}
              </p>
        </div>

        <div className="show-times">
          
        </div>
      </div>

      {/* SCREEN */}
      <div className="screen-area">
        <div className="screen">SCREEN</div>
      </div>

      {/* SEATS */}
      <div className="seat-layout">

        {rows.map((row) => (
          <div className="seat-row" key={row}>

            <span className="row-label">{row}</span>

            {Array.from({ length: seatsPerRow }, (_, index) => {
              const seat = `${row}${index + 1}`;
              const isOccupied = occupiedSeats.includes(seat);
              const isSelected = selectedSeats.includes(seat);

              return (
                <button
                  key={seat}
                  disabled={isOccupied}
                  className={
                    isOccupied
                      ? "seat occupied"
                      : isSelected
                      ? "seat selected"
                      : "seat"
                  }
                  onClick={() => toggleSeat(seat)}
                >
                  {index + 1}
                </button>
              );
            })}

          </div>
        ))}

      </div>
{/* FOOD & BEVERAGES */}
<section className="food-section">
  <div className="food-heading">
    <span className="section-label">ADD TO YOUR EXPERIENCE</span>
    <h2>🍿 Food & Beverages</h2>
    <p>Enjoy your movie with your favourite snacks and drinks.</p>
  </div>

  <div className="food-grid">
    {foodItems.map((item) => {
      const isSelected = selectedFood.some(
        (food) => food.name === item.name
      );

      return (
        <div
          className={isSelected ? "food-card selected" : "food-card"}
          key={item.name}
        >
          <div className="food-icon">{item.icon}</div>

          <div className="food-info">
            <h3>{item.name}</h3>
            <strong>₹{item.price}</strong>
          </div>

          <button
            onClick={() => {
              setSelectedFood((current) =>
                isSelected
                  ? current.filter((food) => food.name !== item.name)
                  : [...current, item]
              );
            }}
          >
            {isSelected ? "Added ✓" : "Add +"}
          </button>
        </div>
      );
    })}
  </div>
</section>
      {/* LEGEND */}
      <div className="seat-legend">

        <div>
          <span className="legend-seat available"></span>
          Available
        </div>

        <div>
          <span className="legend-seat selected"></span>
          Selected
        </div>

        <div>
          <span className="legend-seat occupied"></span>
          Occupied
        </div>

      </div>

      {/* BOOKING SUMMARY */}
      <div className="booking-summary">

        <div>
          <span>Selected Seats</span>
<span>{selectedSeats.length} seat(s)</span>
          <strong>
            {selectedSeats.length > 0
              ? selectedSeats.join(", ")
              : "No seats selected"}
          </strong>
        </div>

        <div>
          <span>Show Time</span>
          <strong>{selectedTime}</strong>
        </div>

    <div>
  <span>Tickets ({selectedSeats.length} × ₹250)</span>
  <strong>₹{totalPrice}</strong>
</div>

<div>
  <span>Food & Beverages</span>
  <strong>₹{foodTotal}</strong>
</div>

<div>
  <span>Total</span>
  <strong>₹{grandTotal}</strong>
</div>

       <button
  className="continue-button"
  disabled={selectedSeats.length === 0}
  title={
    selectedSeats.length === 0
      ? "Please select at least one seat"
      : "Continue to payment"
  }
  onClick={() => {
    window.location.href =
      `/payment?movie=${encodeURIComponent(bookingMovie)}` +
      `&cinema=${encodeURIComponent(bookingCinema)}` +
      `&date=${encodeURIComponent(bookingDate)}` +
      `&time=${encodeURIComponent(selectedTime)}` +
      `&seats=${encodeURIComponent(selectedSeats.join(","))}` +
      `&format=${encodeURIComponent(bookingFormat)}` +
      `&foodTotal=${encodeURIComponent(foodTotal)}` +
      `&location=${encodeURIComponent(bookingLocation)}`;
  }}
>
  Continue to Payment →
</button>

      </div>

    </div>
  );
}

export default Booking;