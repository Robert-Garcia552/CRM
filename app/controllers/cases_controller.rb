class CasesController < ApplicationController
    def new
    end

    def show
    end

    private

    def case_params
		params.
			require(:case).
				permit(
								:type,
								:description,
								:comments
							)
	end
end
