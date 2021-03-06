# frozen_string_literal: true

#
# max.rb
#
module Puppet::Parser::Functions
  newfunction(:max, type: :rvalue, doc: <<-DOC
    @summary
      **Deprecated:** Returns the highest value of all arguments.

    Requires at least one argument.

    @return
      The highest value among those passed in

    > **Note:** **Deprecated** from Puppet 6.0.0, this function has been replaced with a
    built-in [`max`](https://puppet.com/docs/puppet/latest/function.html#max) function.
    DOC
  ) do |args|
    raise(Puppet::ParseError, 'max(): Wrong number of arguments need at least one') if args.empty?

    # Sometimes we get numbers as numerics and sometimes as strings.
    # We try to compare them as numbers when possible
    return args.max do |a, b|
      if a.to_s =~ %r{\A-?\d+(.\d+)?\z} && b.to_s =~ %r{\A-?\d+(.\d+)?\z}
        a.to_f <=> b.to_f
      else
        a.to_s <=> b.to_s
      end
    end
  end
end
