drop database snickr;
create database snickr;
use snickr;

create table SnickrUser(
	uid char(20) primary key,
	name varchar(30) not null,
	nickname varchar(30),
	email varchar(30) unique not null,
	joindate datetime,
	lastlogin datetime
);

create table Workspace(
	wid int auto_increment primary key,
	wname varchar(30) not null,
	wcreatorid char(20),
	wtimestamp datetime,
	foreign key (wcreatorid) references SnickrUser(uid)
);

create table WorkspaceUser(
	wid int,
	uid char(20),
	wauth char(6),
	wutimestamp datetime,
	primary key (wid, uid),
	foreign key (wid) references Workspace(wid),
	foreign key (uid) references SnickrUser(uid)
);

create table Channel(
	cid int auto_increment primary key,
	wid int not null,
	cname varchar(30) not null,
	ctype char(7) not null,
	ccreatorid char(20) not null,
	ctimestamp datetime,
	foreign key (wid) references Workspace(wid),
	foreign key (ccreatorid) references SnickrUser(uid)
);


create table ChannelUser(
	cid int,
	uid char(20),
	cauth char(6),
	cutimestamp datetime,
	primary key (cid, uid),
	foreign key (cid) references Channel(cid),
	foreign key (uid) references SnickrUser(uid)
);

create table Message(
	msgid int auto_increment primary key,
	cid int,
	uid char(20),
	content text,
	mtimestamp datetime,
	foreign key (cid) references Channel(cid),
	foreign key (uid) references SnickrUser(uid),
	foreign key (cid, uid) references ChannelUser(cid, uid)
);

create table WorkspaceInvitation(
	wid int,
	uid char(20),
	witimestamp datetime,
	wistatus char(10),
	wistatuschange datetime,
	primary key (wid, uid, witimestamp),
	foreign key (wid) references Workspace(wid),
	foreign key (uid) references SnickrUser(uid)
);

create table ChannelInvitation(
	cid int,
	uid char(20),
	citimestamp datetime,
	cistatus char(10),
	cistatuschange datetime,
	primary key (cid, uid, citimestamp),
	foreign key (cid) references Channel(cid),
	foreign key (uid) references SnickrUser(uid)
);