# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mait-elk <mait-elk@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/20 11:25:56 by mait-elk          #+#    #+#              #
#    Updated: 2024/02/29 19:08:15 by mait-elk         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CFLAGS= -Wall -Werror -Wextra
CC= cc
INC= include
SRCS= srcs/mscrapper.c
O_SRCS= $(SRCS:.c=.o)
NAME= mgetter

all: $(NAME)

$(NAME): $(O_SRCS) $(NAME).c $(INC)/$(NAME).h
	@$(CC) $(CFLAGS) $(NAME).c $(O_SRCS) -o $(NAME) -lcurl -I $(INC)

%.o: %.c $(INC)/$(NAME).h
	@$(CC) -c $(CFLAGS) $< -o $@ -I $(INC)

clean:
	@rm -f $(O_SRCS)

fclean: clean
	@rm -f $(NAME)

re: fclean all

.PHONY: clean