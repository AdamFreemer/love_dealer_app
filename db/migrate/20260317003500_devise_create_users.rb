# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      # Basic profile (collected on landing page)
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.integer :gender
      t.integer :seeking
      t.text :about

      # Intake form fields
      t.string :phone
      t.string :location
      t.integer :life_stage
      t.text :emotional_availability
      t.boolean :jewish, default: false
      t.string :jewish_identity
      t.text :cultural_values
      t.integer :political_view
      t.integer :alcohol_use
      t.integer :smoking
      t.integer :marijuana_use
      t.integer :neurodivergent
      t.text :neurodivergent_details
      t.text :upbringing
      t.text :grief_or_loss
      t.text :relationship_patterns
      t.text :partner_goals
      t.text :relationship_qualities
      t.text :comfort_lifestyle
      t.text :luxury_relationship
      t.integer :open_to_relocating
      t.integer :interest_level
      t.integer :open_to_zoom_consultation
      t.boolean :agrees_to_consultation, default: false
      t.boolean :agrees_to_no_guarantee, default: false

      # Admin / status
      t.boolean :admin, default: false
      t.integer :status, default: 0
      t.text :admin_notes

      # Intake token for passwordless registration flow
      t.string :intake_token

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :intake_token,         unique: true
  end
end
