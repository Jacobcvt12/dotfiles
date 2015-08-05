def FlagsForFile(filename, **kwargs):

    # main flags
    flags = [
        '-Wall',
        '-Wextra',
        '-Werror'
        '-pedantic',
        '-I',
        '.',
        '-isystem',
        '/usr/include',
        '-isystem',
        '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include',
        '-isystem',
        '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/5.1/include',
        '-isystem',
        '/usr/local/include',
        '-isystem',
        '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/c++/v1',
    ]

    # Rcpp flags
    rcpp_flags = [
        '-I',
        '~/.Rlibs/Rcpp/include',
        '-I',
        '~/.Rlibs/RcppArmadillo/include',
    ]

    flags += rcpp_flags

    data = kwargs['client_data']
    filetype = data['&filetype']

    if filetype == 'c':
        flags += ['-xc']
    elif filetype == 'cpp':
        flags += ['-xc++']
        flags += ['-std=c++11']
    elif filetype == 'objc':
        flags += ['-ObjC']
    else:
        flags = []

    return {
        'flags':    flags,
        'do_cache': True
    }
