module GeoConcerns
  module Extractors
    class OidMetadataExtractor
      attr_reader :oid
      attr_reader :all_returned
      def initialize(oid)
        @oid = oid

        strings = "select a.handle, b.fdid,b.value " +
            "from field_definition a, c12_strings b " +
            "where oid = #{@oid} and a.fdid=b.fdid order by handle"

        lstrings = "select a.handle, b.fdid,b.value " +
            "from field_definition a, c12_longstrings b " +
            "where oid = #{@oid} and a.fdid=b.fdid order by handle"

        acids = "select a.handle, b.fdid,c.value " +
            "from field_definition a, c12_acid b, acid c " +
            "where oid = #{@oid} and a.fdid=b.fdid and b.acid = c.acid order by handle"

        strings_returned = get_results(strings)
        lstrings_returned = get_results(lstrings)
        acids_returned = get_results(acids)
        @all_returned = strings_returned + lstrings_returned + acids_returned
        #puts "RETURN: #{all_returned}"
      end

      def get_results(query)
        ds = SQLServer.execute(query)
        dsArr = Array.new
        ds.each do |i|
          dsArr.push(i)
        end
        ds.cancel
        dsArr
      end

      def fdid_value(fdid)
        return unless @all_returned.find { |x| x["fdid"]==fdid}
        @all_returned.find { |x| x["fdid"]==fdid}["value"]
      end

      def fdid_values(fdid)
        return unless @all_returned.select { |x| x["fdid"]==fdid}
        @all_returned.select { |x| x["fdid"]==fdid}
      end

      def create_values(fdid)
        return unless fdid_value(fdid)
        fields = fdid_values(fdid)
        a = Array.new
        fields.each { |x| a.push(x["value"])}
        a
      end

      def coverage
        return unless fdid_value(290) &&
            fdid_value(291) &&
            fdid_value(292) &&
            fdid_value(293)
        return GeoConcerns::Coverage.new(fdid_value(292),
                   fdid_value(291),
                   fdid_value(293),
                   fdid_value(290)).to_s
      end

      def creators
        create_values(69)
      end

      def description
        create_values(87)
      end

      def title
        create_values(70)
      end

      def issued
        fdid_value(299)
      end

      def publishers
        create_values(69)
      end

      def spatial
          a = Array.new
          a.push(fdid_value(294)) if fdid_value(294)
          a.push(fdid_value(295)) if fdid_value(295)
          a.push(fdid_value(296)) if fdid_value(296)
          a.push(fdid_value(297)) if fdid_value(297)
          a
      end

      def subject
        create_values(90)
      end

      def temporal
        create_values(79)
      end

      def to_hash
        metadata_required.merge(metadata_optional)
      end

      def rights
        if fdid_value(180) == "Open Access"
          return ["Public"]
        else
          return ["Restricted"]
        end
      end

      def metadata_required
        {
            coverage: coverage,
            creator: creators,
            description: description,
            title: title,
            rights: rights,
            provenance: 'Yale' #TODO still says "Your Insitition"
        }.compact
      end

      def metadata_optional
        {
            issued: issued,
            publisher: publishers,
            spatial: spatial,
            subject: subject,
            temporal: temporal
        }.compact
      end
    end
  end
end
