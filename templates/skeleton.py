#!/usr/bin/python3
import click
import logging
import sys

CONTEXT_SETTINGS = dict(help_option_names=["-h", "--help"])


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


def create_logger(name=None, log_level="INFO") -> logging.Logger:
    logger = logging.getLogger(name)
    logger.setLevel(log_level)
    handler = logging.StreamHandler(sys.stdout)
    handler.setFormatter(StreamLogFormatter())
    logger.addHandler(handler)
    return logger


@click.command(context_settings=CONTEXT_SETTINGS)
@click.argument("name", default="world")
@click.option("--log", default="INFO")
def main(**kwargs):
    # Create root logger. In modules, the following line will inherit this root logger:
    # logger = logging.getLogger(__name__)
    logger = create_logger(log_level=kwargs["log"])

    logger.info("Hello, {}!".format(kwargs["name"]))


if __name__ == "__main__":
    main()
