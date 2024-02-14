#!/usr/bin/python3
import argparse
import logging
import sys


class StreamLogFormatter(logging.Formatter):
    COLOR_RESET = "\x1b[0m"
    MSG_FORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"

    COLOR_MAP = {
        logging.DEBUG: "\x1b[38;20m",  # grey
        logging.INFO: "\x1b[38;5;39m",  # blue
        logging.WARNING: "\x1b[33;20m",  # yellow
        logging.ERROR: "\x1b[31;20m",  # red
        logging.FATAL: "\x1b[31;1m",  # bold red
    }

    def format(self, record):
        formatted_msg = (
            self.COLOR_MAP[record.levelno] + self.MSG_FORMAT + self.COLOR_RESET
        )
        formatter = logging.Formatter(formatted_msg)
        return formatter.format(record)


def create_logger(log_level, name=None) -> logging.Logger:
    logger = logging.getLogger()
    logger.setLevel(log_level)
    handler = logging.StreamHandler(sys.stdout)
    handler.setFormatter(StreamLogFormatter())
    logger.addHandler(handler)
    return logger


def get_arguments():
    args = {
        "--log": {
            "help": "Log level",
            "choices": ["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"],
            "default": "INFO",
        },
    }
    parser = argparse.ArgumentParser(description="Main script argument parser.")
    for key, value in args.items():
        parser.add_argument(key, **value)
    return parser.parse_args()


def main():
    # parse arguments
    args = get_arguments()

    # Create root logger. In modules: logger = logging.getLogger(__name__) will inherit this root logger.
    logger = create_logger(args.log)

    logger.info("Hello world!")


if __name__ == "__main__":
    main()
