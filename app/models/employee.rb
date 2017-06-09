class Employee
  attr_accessor :id, :first_name, :last_name, :email, :birthday
  def initialize(hash_options)
    @id = hash_options["id"]
    @first_name = hash_options["first_name"]
    @last_name = hash_options["last_name"]
    @email = hash_options["email"]
    @birthday = Date.parse(hash_options[:birthday]) if hash_options[:birthday]
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def friendly_birthday
    birthday ? birthday.strftime('%b %d, %y') : "N/A"
  end

  def self.find(id)
    Employee.new(
                  Unirest.get("#{ ENV["API_HOST"]}/api/v1/employees/#{ id }.json",
                  headers: {
                            "Accept" => "application/json",
                            "X-User-Email" => ENV["APT_EMAIL"],
                            "Authorization" => "Token token=#{ENV["API_TOKEN"]}"
                            }
                  ).body)
  end

  def self.all
    employees = []
    Unirest.get("#{ ENV["API_HOST"]}/api/v1/employees/#{ id }.json",
      headers: {
                "Accept" => "application/json",
                "X-User-Email" => ENV["APT_EMAIL"],
                "Authorization" => "Token token=#{ENV["API_TOKEN"]}"
                }
      ).body).each do |employee_hash|
      employees << Employee.new(employee_hash)
    end
    employees
  end

  def self.create(employee_params)
    response = Unirest.post(
                            "#{ENV["API_HOST"]}/api/v1/employees.json",
                           headers: {
                                     "Accept" => "application/json",
                                     "X-User-Email" => ENV["APT_EMAIL"],
                                     "Authorization" => "Token token=#{ENV["API_TOKEN"]}"
                                     },
                            parameters: employee_params
                            ).body
    Employee.new(response)
  end

  def update(employee_params)
        response = Unirest.patch(
                            "#{ ENV["API_HOST"]}/api/v1/employees/#{id}.json",
                            headers: {
                                      "Accept" => "application/json",
                                      "X-User-Email" => ENV["APT_EMAIL"],
                                      "Authorization" => "Token token=#{ENV["API_TOKEN"]}"
                                      },
                            parameters: employee_params
                            ).body
      Employee.new(response)
  end

  def destroy
    Unirest.delete(
                    "#{ENV["API_HOST"]}/api/v1/employees/#{id}.json",
                    headers: {
                              "Accept" => "application/json",
                              "X-User-Email" => ENV["APT_EMAIL"],
                              "Authorization" => "Token token=#{ENV["API_TOKEN"]}"
                              }
                  ).body
    
  end
end




