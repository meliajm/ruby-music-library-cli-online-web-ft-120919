require 'pry'

class Song

    extend Concerns::Findable

    attr_accessor :name

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name 
        self.artist = artist if artist != nil && artist.class == Artist
        self.genre = genre if genre != nil && genre.class == Genre
        
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    # def self.create(name)
    #     song = self.new(name)
    #     song.save
    #     song 
    # end
    
    def artist
        @artist
        # @songs.collect{|s| s.artist}.uniq
    end

    def artist=(artist) # question on this do i need an if statement? and do this nd adds the song to the artist's collection of songs
        
        @artist = artist
        # self.artist = Artist.create(artist)
        artist.add_song(self)

    end

    def genre 
        @genre
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end

    # def self.find_by_name(name)
    #     @@all.detect { |song| song.name == name }
    # end

    # def self.find_or_create_by_name(name)
    #    self.find_by_name(name) || self.create(name) 
    # end

    def self.new_from_filename(filename)
        artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
        genre = Genre.find_or_create_by_name(filename.split(" - ")[2].delete_suffix(".mp3"))
        song = self.new(filename.split(" - ")[1], artist, genre)
        # artist.name = filename.split(" - ")[0]
        # song
        # binding.pry
    end

    def self.create_from_filename(filename)
        song = new_from_filename(filename)
        song.save

    end

end