class WordsController < ApplicationController
  before_action :authorize_request

  def index
    # puts params[:sorter]

    # sort = []
    # if params[:sorter] == "en"
    #   sort= ["en", "category"]
    # elsif params[:sorter] == "cn"
    #   sort= ["convert(cn USING GBK)", "convert(category USING GBK)"]
    # else
    #   sort= ["convert(category USING GBK)", "convert(cn USING GBK)"]
    # end
    # words = Word.where(users_id: helpers.get_user_id).order(Word.arel_table[sort[0]].lower.asc)
    # words = Word.where(users_id: helpers.get_user_id).order(sort[1])
    # .order(sort[1])
    # words = words.sort_by { |word| word[sort[1]].mb_chars.upcase.to_s }
    # words = words.sort_by(:&ascii_category)

  #   binds = [ ActiveRecord::Relation::QueryAttribute.new(
  #     "id", helpers.get_user_id, ActiveRecord::Type::Integer.new
  #   ),ActiveRecord::Relation::QueryAttribute.new(
  #     "sort1", sort[0], ActiveRecord::Type::String.new
  #   )
  #   # , $3 ASC
  #   # ,ActiveRecord::Relation::QueryAttribute.new(
  #     # "sort2", sort[1], ActiveRecord::Type::String.new
  #   # )
  # ]

  #   words = ApplicationRecord.connection.exec_query(
  #     'SELECT * FROM words WHERE users_id = $1 ORDER BY $2', 'sql', [ [nil,helpers.get_user_id], [nil,sort[0]] ]
  #   )
  #   puts words

    words = Word.where(users_id: helpers.get_user_id)
    render json: { status: :ok, data: words }
  end
end
