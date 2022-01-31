class Logger:
    def __init__(self):
        self.timer = {}

    def should_print_message(self, timestamp=None, message=None):
        if timestamp is None or message is None :
            return
        if self.timer.__contains__(message):
            if timestamp < self.timer[message]:
                return False
            else:
                self.timer[message] = timestamp + 10
                return True
        else:
            self.timer[message] = timestamp + 10
            return True


logger = Logger()
logger_list = []

print('========================================================\n')
count= int(input("Enter no of logs : "))
while count:
    time_stamp, message = input("Enter timestamp & message separated by space").split(" ")
    logger_list.append(logger.should_print_message(int(time_stamp),message))
    count -= 1

print(f'Printing Logs : {logger_list}\n')
print('========================================================\n')
