# frozen_string_literal: true

module DateDisplay
  extend ActiveSupport::Concern

  DATE_MASK_VALUES = {
    only_year: { mask: 4, format: :year },
    year_month: { mask: 6, format: :year_month },
    complete_date: { mask: 7, format: :long }
  }.freeze

  DAYS = (1..31).to_a
  MONTHS = [
    [I18n.t("date.month_names")[1], 1],
    [I18n.t("date.month_names")[2], 2],
    [I18n.t("date.month_names")[3], 3],
    [I18n.t("date.month_names")[4], 4],
    [I18n.t("date.month_names")[5], 5],
    [I18n.t("date.month_names")[6], 6],
    [I18n.t("date.month_names")[7], 7],
    [I18n.t("date.month_names")[8], 8],
    [I18n.t("date.month_names")[9], 9],
    [I18n.t("date.month_names")[10], 10],
    [I18n.t("date.month_names")[11], 11],
    [I18n.t("date.month_names")[12], 12]
  ].freeze

  included do
    before_save :set_date_and_mask_date

    def date_display(date_field_sym)
      case self.try("#{date_field_sym}_mask")
      when DATE_MASK_VALUES[:only_year][:mask]
        I18n.l(self.try(date_field_sym), format: DATE_MASK_VALUES[:only_year][:format])
      when DATE_MASK_VALUES[:year_month][:mask]
        I18n.l(self.try(date_field_sym), format: DATE_MASK_VALUES[:year_month][:format])
      when DATE_MASK_VALUES[:complete_date][:mask]
        I18n.l(self.try(date_field_sym), format: DATE_MASK_VALUES[:complete_date][:format])
      else
        "s.d."
      end
    end
  end

  private

  # rubocop:disable Layout/LineLength
  def set_date_and_mask_date
    # first we get all DB the columns of type date
    date_columns = self.class.content_columns.select { |col| col.type == :date }
    date_columns.each do |col|
      date_col_name = col.name
      # Here we check if date_col_name column as a corresponding date mask column
      # So if the date_col_name is birth_date, the model should have a birth_date_mask column
      next unless self.attribute_names.include?("#{date_col_name}_mask") && self.attribute_names.include?("#{date_col_name}_year")

      date_integers = { day: self.try("#{date_col_name}_day"), month: self.try("#{date_col_name}_month"), year: self.try("#{date_col_name}_year") }
      # If at least the year is present we mask the date, otherwise we set all corresponding date columns to nil
      if date_integers[:year].present?
        mask_date = mask_date(date_integers)
        self.public_send("#{date_col_name}=", mask_date[:date])
        self.public_send("#{date_col_name}_mask=", mask_date[:mask])
      else
        self.public_send("#{date_col_name}_day=", nil)
        self.public_send("#{date_col_name}_month=", nil)
        self.public_send("#{date_col_name}_year=", nil)
        self.public_send("#{date_col_name}=", nil)
        self.public_send("#{date_col_name}_mask=", nil)
      end
    end
  end
  # rubocop:enable Layout/LineLength

  def mask_date(date_integers)
    if date_integers[:month].blank?
      # If no month and day is given, insert fake month and day
      # 100 -> binary 4
      {
        date: Date.new(date_integers[:year], 1, 1),
        mask: DATE_MASK_VALUES[:only_year][:mask]
      }
    elsif date_integers[:day].blank? && date_integers[:month].present?
      # If no day is given, but the month is given insert a fake day
      # 110 -> binary 6
      {
        date: Date.new(date_integers[:year], date_integers[:month], 1),
        mask: DATE_MASK_VALUES[:year_month][:mask]
      }
    else
      # All fields are given
      # 111 -> binary 7
      {
        date: Date.new(date_integers[:year], date_integers[:month], date_integers[:day]),
        mask: DATE_MASK_VALUES[:complete_date][:mask]
      }
    end
  end
end
