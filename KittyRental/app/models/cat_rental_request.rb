class CatRentalRequest < ActiveRecord::Base
    RENTAL_STATUS = %w(PENDING APPROVED DENIED)

    belongs_to :cat

    validates :cat_id, :start_date, :end_date, :status, presence: true
    validates :status, inclusion: RENTAL_STATUS

    validate :start_must_come_before_end
    validate :does_not_overlap_approved_request

    def approve!
      CatRentalRequest.transaction do
        self.status = "APPROVED"
        self.save! # save the model

        # when we approve this request, we reject all other overlapping
        # requests for this cat.
        overlapping_pending_requests.update_all(status: 'DENIED') ## update_all updates all records
      end
    end

    def denied?
      self.status == "DENIED"
    end

    def deny!
      self.status = "DENIED"
      self.save!
    end

    def pending?
      self.status == "PENDING"
    end

    private

    def overlapping_requests
      CatRentalRequest
        .where.not(id: self.id)
        .where(cat_id: cat_id)
        .where(<<-SQL, start_date: start_date, end_date: end_date)
           NOT( (start_date > :end_date) OR (end_date < :start_date) )
        SQL
    end

    def overlapping_approved_requests
      overlapping_requests.where("status = 'APPROVED'")
    end

    def overlapping_pending_requests
      overlapping_requests.where("status = 'PENDING'")
    end

    def does_not_overlap_approved_request
      return if self.denied?

      unless overlapping_approved_requests.empty?
        errors[:base] <<
          "Request conflicts with existing approved request"
      end
    end

    def start_must_come_before_end
      return if start_date < end_date
      errors[:start_date] << "must come before end date"
      errors[:end_date] << "must come after start date"
    end
  end
