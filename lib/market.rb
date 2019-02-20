require 'pry'
class Market

attr_reader :name,
            :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    vendor_list = []
    vendors.each do |vendor|
      if vendor.inventory.has_key?(item)
        vendor_list << vendor
      end
    end
    vendor_list
  end

  def sorted_item_list
    sorted_list = vendors.map do |vendor|
      vendor.inventory.keys
    end
    sorted_list.flatten.uniq.sort
  end

  def total_inventory
    vendor_inventory = vendors.map do |vendor|
      vendor.inventory
    end
    total_inventory = {}
    vendor_inventory.each do |vendor_inventory_hash|
      vendor_inventory_hash.each do |item, quantity|
        if total_inventory.has_key?(item)
          total_inventory[item] += quantity
        else total_inventory[item] = quantity
        end
      end
    end
    total_inventory
  end

  def sell(item, quantity)
    market_inventory = total_inventory
    if !market_inventory.has_key?(item)
      return false
    elsif market_inventory[item] < quantity
      return false
    else
      vendors.each do |vendor|
        if vendor.inventory[item] >= quantity
          vendor.inventory[item] -= quantity
          return true
        else
          quantity -= vendor.inventory[item]
          vendor.inventory[item] -= vendor.inventory[item]
        end
      end
      return true
    end
  end




end
