# valid classes:
# :warrior	=> focus on STR, END
# :mage			=> focus on INT, WIL
# :thief		=> focus on AGL, PER
$CLASSES = [:warrior,
						:mage,
						:thief]

class Clas # i have to cut off a letter so as not to upset ruby lol
	attr_accessor :name, :spec, :maj, :min, :attrs
	
	def initialize(name)
		@name = name
		@spec = nil
		@maj = []
		@min = []
		@attrs = []
	end
	
	def self.warrior
		c = Clas.new('warrior')
		c.spec = :combat
		c.maj = [:ath, :blk, :hva, :lbl, :mda]
		c.min = [:arm, :axe, :blu, :spr, :mar]
		c.attrs = [:end, :str]; c
	end
	def self.mage
		c = Clas.new('mage')
		c.spec = :magic
		c.maj = [:alt, :des, :ill, :mys, :res]
		c.min = [:alc, :con, :enc, :una, :sbl]
		c.attrs = [:int, :wil]; c
	end
	def self.thief
		c = Clas.new('thief')
		c.spec = :stealth
		c.maj = [:acr, :lta, :sec, :sbl, :snk]
		c.min = [:ath, :h2h, :mar, :mer, :spe]
		c.attrs = [:agl, :spd]; c
	end
end

class Hero
	attr_accessor :name, :clas, :gender, :skills, :stats, :dstats, :cstats, :inv

	def initialize(name, gender, clas)
		@name = name
		@gender = gender
		@clas = clas
		@stats = { # base stats; changed only on level up
			:agl		=> 50,	# agility; ability to dodge/hit, and max fatigue
			:end		=> 50,	# endurance; ability to sustain damage
			:int		=> 50,	# intelligence; how fast you level up, and max mana
			:lck		=> 50,	# luck; affects everything in a small way
			:per		=> 50,	# personality; affects NPC interactions
			:str		=> 50,	# strength; how much you can carry, and melee weapon damage
			:wil		=> 50	# willpower; ability to cast spells effectively, and resist magic
		}

		update_dstats # we already have a method for updating derived stats
		
		@skills = {
			:combat 	=> {
				:arm		=> 5,		# armorer
				:ath		=> 5,		# athletics
				:axe		=> 5,		# axes
				:blk		=> 5,		# block
				:blu		=> 5,		# blunt weapons
				:hva		=> 5,		# heavy armour
				:lbl		=> 5,		# long blade
				:mda		=> 5,		# medium armour
				:spr		=> 5		# spears
			},
			:magic		=> {
				:alc		=> 5,		# alchemy
				:alt		=> 5,		# alteration
				:con		=> 5,		# conjuration
				:des		=> 5,		# destruction
				:enc		=> 5,		# enchanting
				:ill		=> 5,		# illusion
				:mys		=> 5,		# mysticism
				:res		=> 5,		# restoration
				:una		=> 5,		# unarmoured
			},
			:stealth	=> {
				:acr		=> 5,		# acrobatics
				:h2h		=> 5,		# hand to hand
				:lta		=> 5,		# light armour
				:mar		=> 5,		# marksman
				:mer		=> 5,		# mercantile
				:sec		=> 5,		# security
				:sbl		=> 5,		# short blade
				:snk		=> 5,		# sneak
				:spe		=> 5,		# speech
			}
		}
		
		# TODO: calculate skills based on class here

		@cstats = { # current stats; respresent character's current state
			:hp			=> @dstats[:maxhp],	# current HP / health
			:mp			=> @dstats[:maxmp],	# current MP / mana
			:fat		=> @dstats[:maxfat],	# current FAT / fatigue
			:enc		=> 0								# current ENC / encumberance
		}
	end

	def update_dstats
		# recalculate dstats (will need to do this every level up)
		@dstats = { # derived stats; claculated indirectly from base stats
			:maxhp	=> @stats[:end] * 2,								# max HP
			:maxmp	=> @stats[:int] * 2,								# max MP
			:maxfat	=> (@stats[:agl] + @stats[:end]) * 2,	# max fatigue
			:maxenc	=> @stats[:str] * 3,								# max encumberance
			:magres	=> @stats[:wil] / 100.0							# magic resistance (percentage, 0-1)
		}
	end

	def update_enc
		# recalculate current ENC, based on inv
		# TODO: implement
	end

	def to_s
"#{@clas.to_s.capitalize} known as #{@name}
  AGL: #{@stats[:agl]}
  END: #{@stats[:end]}
  INT: #{@stats[:int]}
  LCK: #{@stats[:lck]}
  PER: #{@stats[:per]}
  STR: #{@stats[:str]}
  WIL: #{@stats[:wil]}

  HP:  #{@cstats[:hp]}\t/ #{@dstats[:maxhp]}
  MP:  #{@cstats[:mp]}\t/ #{@dstats[:maxmp]}
  FAT: #{@cstats[:fat]}\t/ #{@dstats[:maxfat]}
  ENC: #{@cstats[:enc]}\t/ #{@dstats[:maxenc]}
"
	end

end