# frozen_string_literal: true

module FullTextSearch
  extend ActiveSupport::Concern

  included do
    after_save :create_ts_vector

    scope :general_search, (lambda do |query|
      order = Arel.sql("ts_rank(document_ts_vector, websearch_to_tsquery('portuguese','#{query}')) DESC")
      select("#{self.table_name}.*, #{order.gsub(/ desc/i, '')}")
      .where("document_ts_vector @@ websearch_to_tsquery('portuguese', ?)", query).order(order)
    end)
  end

  class_methods do
    def ransackable_scopes(_auth_object = nil)
      %i[general_search]
    end
  end

  private

  def create_ts_vector
    plain_text_record = self.create_plain_text

    set_sql = self.class.sanitize_sql_for_assignment(
      ["document_ts_vector = to_tsvector('portuguese', :plain_text_record)", { plain_text_record: plain_text_record }]
    )
    where_sql = self.class.sanitize_sql_for_conditions(["id = :id", { id: self.id }])

    query = "UPDATE #{self.class.table_name} SET #{set_sql} WHERE #{where_sql}"

    self.class.connection.exec_update(query, "FullTextSearch Update")
  end
end
