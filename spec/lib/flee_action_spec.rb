require 'spec_helper'
require_relative '../../lib/flee_action'

describe FleeAction do
	let(:hero) { double("hero", strength: 3, gain_experience: nil, gain_gold: nil, damage: nil, stealth: 3)}
	let(:action) { FleeAction.new hero, dicepool}
	let(:dicepool) { double("dicepool")}
 	let(:monster) { double("monster", toughness: 2, kill: nil, damage: 4, notice: 2)}

  describe "effect" do
    context "success" do
       it "sends flee message to the owner" do 
       	dicepool.stub(:skill_check).and_return(true)
       	hero.should_receive(:flee)
       	action.activate(monster)
       end
    end

    context "failure" do 
    	it "deals damage to the owner" do
    		dicepool.stub(:skill_check).and_return(false)
    		hero.should_receive(:damage).with(monster.damage)
    		action.activate(monster)
    	end
    end
  end

  describe "activate" do

    it "makes stealth check against target notice" do 
	 
      dicepool.should_receive(:skill_check).with(hero.stealth, monster.notice)
      action.activate(monster)
	  
    end
  end

  it "responds to activate message" do 
  	expect(action).to respond_to(:activate)
  end

  it "has an owner" do 
   	expect(action.owner).to eq(hero)
  end


end