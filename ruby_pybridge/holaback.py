from subprocess import Popen, PIPE, STDOUT

print 'launching hola process...'
hola = Popen(['ruby', 'hola.rb'], stdin=PIPE, stdout=PIPE, stderr=STDOUT)

while True:
    line = raw_input('Enter expression or exit:')
    hola.stdin.write(line+'\n')
    result = []
    while True:
        if hola.poll() is not None:
            print 'hola has terminated.'
            exit()
        line = hola.stdout.readline().rstrip()
        if line == '[end]':
            break
        result.append(line)
    print 'result:'
    print '\n'.join(result)
