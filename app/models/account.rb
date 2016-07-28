class Account < ApplicationRecord
  belongs_to :user

  def self.open(params)
    puts "Creating a account with #{params}"
    account = new(params)
    account.save
  end

  def self.deposit(account, amount)
    puts "Depositing #{amount} on account #{account.id}"

    if amount <= 0
      puts 'Deposit failed! Amount must be greater than 0.00'
      return false
    end

    account.balance = (account.balance += amount).round(2)
    account.save
  end

  def self.withdraw(account, amount)
    puts "Withdrawing #{amount} on account #{account.id}"

    if amount <= 0
      puts 'Withdraw failed! Amount must be greater than 0.00'
      return false
    end

    account.balance = (account.balance -= amount).round(2)
    account.save
  end

  def self.transfer(account, recipient, amount)
    puts "Transfering #{amount} from account #{account.id} to account #{recipient.id}"

    if amount <= 0
      puts 'Transfer failed! Amount must be greater than 0.00'
      return false
    end

    self.withdraw(account, amount)
    self.deposit(recipient, amount)
  end
end
