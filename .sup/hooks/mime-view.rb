# filename has already been shellesacped
pid = Process.spawn("xdg-open", filename,
                    :out => '/dev/null',
                    :err => '/dev/null')

Process.detach pid

true
