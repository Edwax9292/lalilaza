drop schema if exists gamesSchema cascade;
create schema gamesSchema;
set search_path to Games;



create domain Score as float
	default null
	check (value>=0 and value <=100);

create domain Rating as varchar(4)
	default null
	check (value in ('E','E10+','T','A'));

create table Games(
	gameID integer not null,
	name varchar(100) not null,
	platform varchar(25) not null,
	devID integer not null,
	year integer not null,
	unique(gameID, devID),
	primary key (gameID));

create table Sales(
	gameID integer references Games(gameID),
	naSales float not null,
	euSales float not null,
	jpSales float not null,
	otherSales float not null,
	globalSales float not null,
	primary key (gameID));

create table Ratings(
	gameID integer references Games(gameID),
	userScore Score not null,
	criticScore Score not null,
	esrbRating Rating not null,
	primary key (gameID));

create table Developers(
	devID integer references Games(devID),
	devName varchar(25) not null,
	totalSales float not null,
	numGames integer not null,
	primary key (devID));

create table Genres(
	gameID integer references Games(gameID),
	genre varchar(25) not null,
	primary key (gameID));

create table Published(
	gameID integer reference Games(gameID),
	devID integer reference Games(devID),
	pubID integer reference Publishers(pubID),
	unique (gamID, devID, pubID),
	primary key (gameID));

create table Publishers(
	pubID integer not null,
	pubName varchar(25) not null,
	numGames integer not null,
	totoalSales float not null,
	primary key(pubID));