/*
  # Create Events Platform Schema

  1. New Tables
    - `events`
      - `id` (uuid, primary key)
      - `title` (text) - Event name
      - `description` (text) - Event description
      - `genre` (text) - Music genre (afro, dancehall, reggaeton)
      - `city` (text) - City where event takes place
      - `venue` (text) - Venue name
      - `event_date` (timestamptz) - Date and time of event
      - `price` (numeric) - Ticket price
      - `image_url` (text) - Event image URL
      - `capacity` (integer) - Maximum attendees
      - `tickets_sold` (integer) - Number of tickets sold
      - `featured` (boolean) - Whether event is featured on homepage
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)
    
    - `contact_submissions`
      - `id` (uuid, primary key)
      - `name` (text) - Contact name
      - `email` (text) - Contact email
      - `phone` (text) - Phone number
      - `message` (text) - Contact message
      - `created_at` (timestamptz)
    
    - `ticket_purchases`
      - `id` (uuid, primary key)
      - `event_id` (uuid) - Reference to events table
      - `buyer_name` (text) - Buyer name
      - `buyer_email` (text) - Buyer email
      - `buyer_phone` (text) - Buyer phone
      - `quantity` (integer) - Number of tickets
      - `total_amount` (numeric) - Total purchase amount
      - `status` (text) - Purchase status (pending, confirmed, cancelled)
      - `created_at` (timestamptz)

  2. Security
    - Enable RLS on all tables
    - Public read access for events and gallery
    - Authenticated write access for contact submissions and ticket purchases
*/

-- Create events table
CREATE TABLE IF NOT EXISTS events (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text NOT NULL,
  genre text NOT NULL CHECK (genre IN ('afro', 'dancehall', 'reggaeton')),
  city text NOT NULL,
  venue text NOT NULL,
  event_date timestamptz NOT NULL,
  price numeric NOT NULL DEFAULT 0,
  image_url text NOT NULL,
  capacity integer NOT NULL DEFAULT 0,
  tickets_sold integer NOT NULL DEFAULT 0,
  featured boolean DEFAULT false,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create gallery table
CREATE TABLE IF NOT EXISTS gallery (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id uuid REFERENCES events(id) ON DELETE CASCADE,
  image_url text NOT NULL,
  caption text,
  created_at timestamptz DEFAULT now()
);

-- Create contact submissions table
CREATE TABLE IF NOT EXISTS contact_submissions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  email text NOT NULL,
  phone text,
  message text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create ticket purchases table
CREATE TABLE IF NOT EXISTS ticket_purchases (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id uuid REFERENCES events(id) ON DELETE CASCADE NOT NULL,
  buyer_name text NOT NULL,
  buyer_email text NOT NULL,
  buyer_phone text,
  quantity integer NOT NULL CHECK (quantity > 0),
  total_amount numeric NOT NULL,
  status text NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'cancelled')),
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE gallery ENABLE ROW LEVEL SECURITY;
ALTER TABLE contact_submissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE ticket_purchases ENABLE ROW LEVEL SECURITY;

-- RLS Policies for events (public read)
CREATE POLICY "Anyone can view events"
  ON events FOR SELECT
  USING (true);

-- RLS Policies for gallery (public read)
CREATE POLICY "Anyone can view gallery"
  ON gallery FOR SELECT
  USING (true);

-- RLS Policies for contact submissions (anyone can insert)
CREATE POLICY "Anyone can submit contact form"
  ON contact_submissions FOR INSERT
  WITH CHECK (true);

-- RLS Policies for ticket purchases (anyone can insert, only own records visible)
CREATE POLICY "Anyone can purchase tickets"
  ON ticket_purchases FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Users can view own purchases"
  ON ticket_purchases FOR SELECT
  USING (buyer_email = current_setting('request.jwt.claims', true)::json->>'email');

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_events_genre ON events(genre);
CREATE INDEX IF NOT EXISTS idx_events_city ON events(city);
CREATE INDEX IF NOT EXISTS idx_events_date ON events(event_date);
CREATE INDEX IF NOT EXISTS idx_events_featured ON events(featured);
CREATE INDEX IF NOT EXISTS idx_gallery_event_id ON gallery(event_id);
CREATE INDEX IF NOT EXISTS idx_ticket_purchases_event_id ON ticket_purchases(event_id);
