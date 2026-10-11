import { useState } from "react";
import { API_BASE_URL } from "./api";

type ChatMessage = {
  sender: "bot" | "user";
  text: string;
};

function Chatbot() {
  const [isOpen, setIsOpen] = useState(false);
  const [message, setMessage] = useState("");

  const [messages, setMessages] = useState<ChatMessage[]>([
    {
      sender: "bot",
      text: "👋 Hi! I'm CineReserve AI.",
    },
    {
      sender: "bot",
      text: "I can help with bookings, cancellations, refunds, seats and payments.",
    },
  ]);

  const getBotReply = (text: string) => {
    const input = text.toLowerCase();

    if (
      input.includes("cancel") ||
      input.includes("cancellation")
    ) {
      return "🎟️ To cancel a booking, please provide your booking ID. Our support team can check the booking and cancellation eligibility.";
    }

    if (
      input.includes("refund") ||
      input.includes("money back")
    ) {
      return "💰 Refunds depend on the cancellation policy and booking status. Please provide your booking ID so we can check it.";
    }

    if (
      input.includes("book") ||
      input.includes("booking")
    ) {
      return "🎬 To book a movie, select a movie, choose your cinema, date, showtime and format, then select your seats and complete payment.";
    }

    if (
      input.includes("seat") ||
      input.includes("seats")
    ) {
      return "💺 Available seats are shown in the seat selection page. Seats marked as occupied cannot be selected.";
    }

    if (
      input.includes("payment") ||
      input.includes("pay")
    ) {
      return "💳 CineReserve supports card and UPI payment options in the payment section.";
    }

    if (
      input.includes("movie") ||
      input.includes("movies")
    ) {
      return "🎥 You can browse available movies from the Movies section and filter them by genre, language and cinema.";
    }

    if (
      input.includes("hello") ||
      input.includes("hi") ||
      input.includes("hey")
    ) {
      return "👋 Hello! How can I help you with your CineReserve booking?";
    }

    return "🤖 I'm here to help with CineReserve bookings, cancellations, refunds, seats and payments. Please ask me about one of these.";
  };

  const sendMessage = async () => {
  const trimmedMessage = message.trim();

  if (!trimmedMessage) {
    return;
  }

  const userMessage: ChatMessage = {
    sender: "user",
    text: trimmedMessage,
  };

  setMessages((current) => [...current, userMessage]);
  setMessage("");

  const bookingMatch = trimmedMessage.match(
    /(?:cancel|cancellation).*?(CR\d{6})/i
  );

  if (bookingMatch) {
    const bookingId = bookingMatch[1];

    try {
      const response = await fetch(
        `${API_BASE_URL}/api/bookings/cancel`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            bookingId,
          }),
        }
      );

      const result = await response.json();

      setMessages((current) => [
        ...current,
        {
          sender: "bot",
          text: response.ok
            ? `✅ ${result.message} Booking ID: ${bookingId}`
            : `❌ ${result.message}`,
        },
      ]);
    } catch (error) {
      console.error("Cancellation error:", error);

      setMessages((current) => [
        ...current,
        {
          sender: "bot",
          text: "❌ Unable to connect to the booking server. Please try again.",
        },
      ]);
    }

    return;
  }

  const botMessage: ChatMessage = {
    sender: "bot",
    text: getBotReply(trimmedMessage),
  };

  setMessages((current) => [
    ...current,
    botMessage,
  ]);
};

  return (
    <>
      <button
        className="chatbot-button"
        onClick={() => setIsOpen(!isOpen)}
      >
        💬
      </button>

      {isOpen && (
        <div className="chatbot-box">
          <div className="chatbot-header">
            <strong>CineReserve AI</strong>

            <button
              onClick={() => setIsOpen(false)}
            >
              ✕
            </button>
          </div>

          <div className="chatbot-messages">
            {messages.map((msg, index) => (
              <p
                key={index}
                style={{
                  alignSelf:
                    msg.sender === "user"
                      ? "flex-end"
                      : "flex-start",

                  background:
                    msg.sender === "user"
                      ? "#e50914"
                      : "#1c1c1c",

                  color: "white",

                  borderRadius:
                    msg.sender === "user"
                      ? "12px 12px 4px 12px"
                      : "12px 12px 12px 4px",
                }}
              >
                {msg.text}
              </p>
            ))}
          </div>

          <div className="chatbot-input">
            <input
              type="text"
              placeholder="Ask something..."
              value={message}
              onChange={(e) =>
                setMessage(e.target.value)
              }
              onKeyDown={(e) => {
                if (e.key === "Enter") {
                  sendMessage();
                }
              }}
            />

            <button onClick={sendMessage}>
              Send
            </button>
          </div>
        </div>
      )}
    </>
  );
}

export default Chatbot;