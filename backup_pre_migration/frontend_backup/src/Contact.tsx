function Contact() {
  return (
    <div className="contact-page">
      <div className="contact-header">
        <span className="section-label">CONTACT CINERESERVE</span>

        <h1>Get In Touch</h1>

        <p>
          Have a question, suggestion or need help with your booking?
          Send us a message and our team will get back to you.
        </p>
      </div>

      <div className="contact-content">
        <div className="contact-info">
          <h2>We're Here to Help</h2>

          <p>
            Whether you need help with a booking, payment, cancellation
            or anything else, feel free to contact us.
          </p>

          <div className="contact-item">
            <span>📧</span>
            <div>
              <strong>Email</strong>
              <p>support@cinereserve.com</p>
            </div>
          </div>

          <div className="contact-item">
            <span>📞</span>
            <div>
              <strong>Phone</strong>
              <p>+91 98765 43210</p>
            </div>
          </div>

          <div className="contact-item">
            <span>📍</span>
            <div>
              <strong>Location</strong>
              <p>Hyderabad, Telangana</p>
            </div>
          </div>
        </div>

        <form
          className="contact-form"
          onSubmit={(e) => {
            e.preventDefault();
            alert("Thank you! Your message has been sent.");
          }}
        >
          <label>Name</label>
          <input
            type="text"
            placeholder="Enter your name"
            required
          />

          <label>Email</label>
          <input
            type="email"
            placeholder="Enter your email"
            required
          />

          <label>Message</label>
          <textarea
            placeholder="Write your message..."
            rows={6}
            required
          ></textarea>

          <button type="submit">
            Send Message →
          </button>
        </form>
      </div>
    </div>
  );
}

export default Contact;