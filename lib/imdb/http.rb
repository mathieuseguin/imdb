module IMDB
  class HTTP
    def self.get(url)
      begin
        if IMDB.cache.is_a?(FileCache)
          cache_name = Digest::MD5.hexdigest(url)
          body = IMDB.cache.get(cache_name)
          if body.nil?
            body = open(url).read
            IMDB.cache.set(cache_name, body)
          end
          body
        else
          body = open(url).read
        end
      rescue => e
        p "Error: #{e.message}"
        nil
      end
    end
  end
end