# Internal Conversations Feature (Option B: Turbo Streams)

## Overview

CRM-style internal messaging between admins and customers. All communications contained within the app. Real-time updates via Turbo Streams + Solid Cable (already in stack).

## Data Model

```
Conversation
  - customer_id (belongs_to User, one per customer)
  - created_at

Message
  - conversation_id (belongs_to Conversation)
  - sender_id (belongs_to User — could be admin or customer)
  - body (text)
  - read_at (datetime, null = unread)
  - created_at
```

## Routes

```ruby
# Customer side
resource :conversation, only: [:show] do
  resources :messages, only: [:create]
end

# Admin side
namespace :admin do
  resources :conversations, only: [:index, :show] do
    resources :messages, only: [:create]
  end
end
```

## Pages

### Customer Side

**`/conversation`** (their single conversation)

- Uses landing layout (dark theme)
- Shows all messages chronologically, styled as a thread
- Admin vs customer messages visually distinguished by color
- Text area + submit button at bottom
- On submit: Turbo Stream appends new message (no page reload)
- `turbo_stream_from @conversation` subscribes to live updates via WebSocket

### Admin Side

**`/admin/conversations`** (index)

- Uses admin layout (light theme)
- Table: customer name, last message preview, unread count, last activity
- Click row to enter conversation

**`/admin/conversations/:id`** (show — thread)

- Full message thread with customer
- Text area + submit at bottom
- Turbo Stream append on submit + broadcast subscription
- Marks messages as read when admin views them

## Key Files

```
# Models
app/models/conversation.rb
app/models/message.rb

# Controllers
app/controllers/conversations_controller.rb
app/controllers/messages_controller.rb
app/controllers/admin/conversations_controller.rb
app/controllers/admin/messages_controller.rb

# Views
app/views/conversations/show.html.erb
app/views/admin/conversations/index.html.erb
app/views/admin/conversations/show.html.erb
app/views/messages/_message.html.erb              # shared partial
```

## Real-Time Mechanism

In `message.rb`:
```ruby
after_create_commit -> {
  broadcast_append_to conversation,
    target: "messages",
    partial: "messages/message"
}
```

In both conversation show views:
```erb
<%= turbo_stream_from @conversation %>
<div id="messages">
  <%= render @conversation.messages %>
</div>
```

Rails handles WebSocket plumbing through Solid Cable. The `_message.html.erb` partial is shared everywhere — form response, broadcast, and initial page load.

## Optional Enhancements

- Email notification on new message
- Unread badge in nav
- Auto-scroll to bottom on new message (small Stimulus controller)
- File/image attachments via Active Storage
