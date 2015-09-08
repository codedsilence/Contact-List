require_relative 'contact'
require_relative 'contact_database'
require 'pry'
class Contact_list

  # get users input
  def self.get_user_input
    STDIN.gets.chomp
  end

  # get users phone numbers
  def self.get_phone_num
    phone_number = {}
	  end_loop = false
    until end_loop
      puts "Do you have a phone number? (Y/N)"
      command = get_user_input
      case command
      when "Y"
        puts "Please input the ID name now:"
        label = get_user_input
        puts "Please input the number itself now:"
        number = get_user_input
        phone_number[label] = number
        # Contact.create(phone_number)
        end_loop = true
      when "N"
        break
      end
    end
    
    phone_number
  end

  # print contact details in separate lines
  def self.puts_details(contact)
    puts "Name: #{contact.name}"
    puts "Email: #{contact.email}"
    puts "Phone number: #{contact.phone_numbers}"
  end

  # determine which command to execute
  def self.which_command_to_execute(command)
    case command
    when "help" then help_menu
    when "new" then create_contact
    when "list" then list_contacts
    when "show" then show_contact
    when "find" then find_contact
    end
  end

  # helper menu
  def self.help_menu
    puts "Available commands:"
    puts "new - Create a new contact"
    puts "list - List all contacts"
    puts "show - Show a contact"
    puts "find - Find a contact"
  end

  # create a contact
  def self.create_contact
    puts "Please input the email:"
    email = get_user_input
    if Contact.duplicate?(email)
      puts "That contact already exists"
      return
    else
      puts "Please input the full name:"
      name = get_user_input
    end

    phone_number = get_phone_num

    puts Contact.create(name, email, phone_number)
  end
  

  # list all contacts
  def self.list_contacts
    contacts_str_arr = Contact.all
    contacts_str_arr.each do |contact_str|
      puts contact_str
    end
  end

  # show a contact with ID
  def self.show_contact  
    contact = Contact.show(ARGV[1])
    if contact
      puts_details(contact)
    else
      puts "Sorry we couldn't find a contact with ID #{ARGV[1]}"
    end
  end

  # find a contact with term
  def self.find_contact
    search_term = ARGV[1]
    contact = Contact.find(search_term)
    if contact
      puts_details(contact)
    else
      puts "Sorry we couldn't find a contact with the search term #{search_term}"
    end
  end

end

Contact_list.which_command_to_execute(ARGV[0])