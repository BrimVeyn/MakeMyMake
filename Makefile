# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bvan-pae <bryan.vanpaemel@gmail.com>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/03/15 11:21:29 by bvan-pae          #+#    #+#              #
#    Updated: 2024/03/22 14:10:05 by bvan-pae         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CPP 	:= g++
CFLAGS 	:= -Wall -Wextra -Werror -std=c++17

NAME 	:= mmm

SRC		:= main.cpp
OBJ 	:= $(SRC:%.cpp=%.o)

all : $(NAME)

%.o: %.cpp
	$(CPP) $(CFLAGS) -c $< -o $@

$(NAME) : $(OBJ)
	$(CPP) $(CFLAGS) $(OBJ) -o $(NAME)

clean:
	rm -rf $(OBJ)

fclean:
	rm -rf $(OBJ) $(NAME)

re:	fclean all
