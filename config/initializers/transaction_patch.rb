require 'active_record/connection_adapters/abstract/transaction'

module ActiveRecord
  module ConnectionAdapters
    class Transaction
      def add_record(record, ensure_finalize = true)
        @records ||= []
        if ensure_finalize
          @records << record
        else
          @lazy_enrollment_records ||= ObjectSpace::WeakMap.new

          m = Benchmark.measure do
            @lazy_enrollment_records[record] = record
          end
          puts m
          record
        end
      end
    end
  end
end
