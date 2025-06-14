# Development Guide

## Getting Started

### Prerequisites
- Ruby 3.2.0 or higher
- Rails 7.0 or higher
- PostgreSQL
- Node.js and Yarn
- Redis (for Sidekiq)
- ImageMagick (for image processing)

### Initial Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/book-sharing.git
cd book-sharing
```

2. Install dependencies:
```bash
bundle install
yarn install
```

3. Set up environment variables:
```bash
cp .env.example .env
```
Edit `.env` with your local configuration.

4. Set up the database:
```bash
rails db:create
rails db:migrate
rails db:seed
```

5. Start the development server:
```bash
rails server
```

6. Start Sidekiq (in a separate terminal):
```bash
bundle exec sidekiq
```

### Development Workflow

1. **Branch Management**
   - Create feature branches from `main`
   - Use descriptive branch names (e.g., `feature/user-authentication`)
   - Keep branches up to date with `main`

2. **Code Style**
   - Follow Ruby style guide
   - Use RuboCop for linting
   - Write meaningful commit messages

3. **Testing**
   - Write tests for new features
   - Run the test suite:
     ```bash
     bundle exec rspec
     ```
   - Maintain test coverage above 80%

4. **Database Changes**
   - Create migrations for schema changes
   - Include both `up` and `down` methods
   - Test migrations in development

### Key Development Tasks

#### 1. Adding a New Feature

1. Create a new branch:
```bash
git checkout -b feature/new-feature
```

2. Implement the feature:
   - Add models/controllers/views
   - Write tests
   - Update documentation

3. Submit a pull request:
   - Include tests
   - Update documentation
   - Request code review

#### 2. Database Migrations

1. Generate a migration:
```bash
rails generate migration AddColumnToTable
```

2. Edit the migration file:
```ruby
class AddColumnToTable < ActiveRecord::Migration[7.0]
  def change
    add_column :table_name, :column_name, :string
  end
end
```

3. Run the migration:
```bash
rails db:migrate
```

#### 3. Adding a New Gem

1. Add the gem to `Gemfile`:
```ruby
gem 'new_gem'
```

2. Install the gem:
```bash
bundle install
```

3. Configure the gem in `config/initializers/`

### Testing

#### 1. Running Tests

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/user_spec.rb

# Run tests with coverage
COVERAGE=true bundle exec rspec
```

#### 2. Writing Tests

```ruby
# spec/models/book_spec.rb
require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:transactions) }
  end
end
```

### Debugging

#### 1. Using Pry

```ruby
# Add to your code
binding.pry
```

#### 2. Logging

```ruby
Rails.logger.debug "Debug message"
Rails.logger.info "Info message"
Rails.logger.warn "Warning message"
Rails.logger.error "Error message"
```

### Performance Optimization

#### 1. Database Optimization

- Use indexes for frequently queried columns
- Optimize N+1 queries using includes
- Use counter caches where appropriate

#### 2. Caching

```ruby
# Fragment caching
<% cache @book do %>
  <%= render @book %>
<% end %>

# Russian Doll caching
<% cache [@book, @book.user] do %>
  <%= render @book %>
<% end %>
```

### Security Best Practices

1. **Authentication**
   - Use Devise for user authentication
   - Implement strong password requirements
   - Use secure session management

2. **Authorization**
   - Use Pundit for authorization
   - Implement role-based access control
   - Validate user permissions

3. **Data Protection**
   - Sanitize user input
   - Use strong parameters
   - Implement CSRF protection

### Deployment

#### 1. Production Setup

1. Configure production environment:
```bash
RAILS_ENV=production bundle exec rails assets:precompile
```

2. Set up production database:
```bash
RAILS_ENV=production bundle exec rails db:migrate
```

3. Configure web server (e.g., Nginx)

#### 2. Monitoring

- Set up New Relic
- Configure error tracking
- Set up logging

### Common Issues and Solutions

#### 1. Database Issues

- Reset database:
```bash
rails db:drop db:create db:migrate db:seed
```

- Check database connection:
```bash
rails dbconsole
```

#### 2. Asset Pipeline Issues

- Clear asset cache:
```bash
rails assets:clean
```

- Recompile assets:
```bash
rails assets:precompile
```

### Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Write tests
5. Submit a pull request

### Resources

- [Ruby on Rails Guides](https://guides.rubyonrails.org/)
- [RSpec Documentation](https://rspec.info/documentation/)
- [Devise Documentation](https://github.com/heartcombo/devise)
- [Pundit Documentation](https://github.com/varvet/pundit)
