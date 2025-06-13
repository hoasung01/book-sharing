module BookRules
  extend ActiveSupport::Concern

  included do
    before_action :validate_book_creation, only: [ :create ]
  end

  private

  def validate_book_creation
    return if book_params[:title].present? &&
              book_params[:author].present? &&
              book_params[:isbn].present? &&
              valid_isbn?(book_params[:isbn]) &&
              valid_year?(book_params[:published_year])

    flash[:error] = "Invalid book data. Please check all required fields."
    render :new, status: :unprocessable_entity
  end

  def valid_isbn?(isbn)
    # Basic ISBN validation (10 or 13 digits)
    isbn.to_s.gsub(/[^0-9]/, "").length.in?([ 10, 13 ])
  end

  def valid_year?(year)
    year.to_i.between?(1900, Time.current.year)
  end
end
