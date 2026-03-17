---
name: Love Dealer MVP Plan
description: Core MVP decisions and architecture for the Love Dealer matchmaking app
type: project
---

**The Love Dealer** is a Jewish matchmaking service app.

## Key Architecture Decisions

### User Flow
1. Landing page has a basic intake form (first_name, last_name, email, city, state, zipcode, age, gender, seeking, services interested in, about text)
2. All basic form fields are required
3. Submitting basic form creates User record WITHOUT password (no login capability)
4. User sees "someone will respond to you shortly" confirmation
5. "Click here to help us understand you better" button redirects to dedicated intake page (IntakeController)
6. Intake page has ALL detailed questions + password fields, appends to existing User record
7. After setting password on intake page, user can log in

### User Model
- Devise for authentication (skip email confirmation for MVP)
- `admin` boolean flag (set manually via console, no roles system)
- `status` enum: under_review (default), accepted, please_contact
- All fields from intake form screenshot (see intake form fields below)
- first_name / last_name (not single name field)
- city, state, zipcode for location

### Services
- Three defaults: "Dating Coaching", "Personal Matchmaking", "Group Mixer"
- Service model: name, notes (global notes)
- UserService join table for many-to-many
- Just storing interest for now, more functionality later

### Pages
- PUBLIC: Landing page (root)
- PUBLIC: Expanded intake form (IntakeController)
- PUBLIC: Login (Devise)
- PUBLIC: Customer dashboard (read-only profile + status)
- INTERNAL: Admin customer index
- INTERNAL: Admin customer show
- INTERNAL: Admin customer edit (status changes)

### Styling
- Landing page: dark theme, adapted from love_dealer_landing.html to TailwindCSS
- Admin pages: minimal Tailwind, not as polished
- Images: jamie1.png (dark bg), jamie2.png (light bg) in app root

### Deployment
- GitHub: github.com/AdamFreemer/love_dealer_app
- Deploying to Heroku
- Solid Queue/Cache/Cable with Postgres (no Redis)

### Intake Form Fields (from screenshot)
- phone_number
- location (city/state/zipcode on basic, free text on intake)
- life_stage (enum/select)
- emotional_availability (text)
- jewish_identity (boolean)
- jewish_denomination (text/select)
- religious_values_important (text)
- political_view (enum/select)
- alcohol_use (enum/select)
- smoking (enum/select)
- marijuana_use (enum/select)
- neurodivergent (enum/select)
- neurodivergent_details (text)
- upbringing_description (text)
- grief_or_loss (text)
- grief_influence_on_relationships (text)
- partner_goals (text)
- important_qualities (text)
- comfort_lifestyle_importance (text)
- relationship_to_luxury (text)
- open_to_relocating (enum/select)
- interest_level (enum/select)
- open_to_zoom_consultation (enum/select)
- consent_acknowledged (boolean)

**Why:** MVP needs to capture detailed intake info for matchmaking while keeping the UX simple with a two-step form flow.
**How to apply:** All development follows phased approach with commits per phase. Admin functionality is minimal/functional, public pages match the dark-themed landing page aesthetic.
