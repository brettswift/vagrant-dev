class ChangeMessageColumnTypeToMediumTextOnReportLogs < ActiveRecord::Migration
  def self.up
    change_column :report_logs, :message, :text, :limit => 65536
  end

  def self.down
    change_column :report_logs, :message, :text
  end
end
