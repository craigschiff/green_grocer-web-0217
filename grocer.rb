require 'pry'

def consolidate_cart(cart)
    count_hash = {}
    final_hash = {}
    cart.each do |hash|
        hash.each do |item, detail|
            if count_hash[item] == nil
                count_hash[item] = 1
                else
                count_hash[item] += 1
            end
            final_hash[item] = detail
            final_hash[item][:count] = count_hash[item]
        end
    end
    final_hash
    
    # code here
end

def apply_coupons(cart, coupons)
    coupons.each do |hash|
        name = hash[:item]
        if cart[name] && cart[name][:count] >= hash[:num]
            if cart["#{name} W/COUPON"] == nil
                cart["#{name} W/COUPON"] = {}
                cart["#{name} W/COUPON"][:price] = hash[:cost]
                cart["#{name} W/COUPON"][:clearance] = cart["#{hash[:item]}"][:clearance]
                cart["#{name} W/COUPON"][:count] = 1
                cart["#{name}"][:count] -= hash[:num]
                else
                cart["#{name} W/COUPON"][:count] += 1
                cart["#{name}"][:count] -= hash[:num]
            end
        end
    end
    cart
end

def apply_clearance(cart)
    new_price = 0
    cart.each do |key, details|
        if details[:clearance] == true
            new_price = details[:price] * 0.8
            details[:price] = new_price.round(1)
        end
    end
    cart
end




def checkout(cart, coupons)
    total_cost = 0
    consolidated_cart = consolidate_cart(cart)
    cart_with_coupons = apply_coupons(consolidated_cart, coupons)
    cart_final = apply_clearance(cart_with_coupons)
    cart_final.each do |name, hash|
        total_cost += hash[:price] * hash[:count]
    end
    if total_cost > 100
        total_cost = total_cost * 0.9
    end
    total_cost
end