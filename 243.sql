/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2020/12/1 15:43:55                           */
/*==============================================================*/


drop table if exists coupon;

drop table if exists coupon_have;

drop table if exists full_reduction_scheme;

drop table if exists merchant;

drop table if exists order_address;

drop table if exists order_details;

drop table if exists product;

drop table if exists product_category;

drop table if exists product_comment;

drop table if exists product_order;

drop table if exists send_coupon;

drop table if exists user;

drop table if exists xiaoqu;

/*==============================================================*/
/* Table: coupon                                                */
/*==============================================================*/
create table coupon
(
   c_code               int not null,
   m_id                 int,
   c_price              decimal(11,2),
   c_number             int,
   start_date           datetime,
   end_date             datetime,
   primary key (c_code)
);

/*==============================================================*/
/* Table: coupon_have                                           */
/*==============================================================*/
create table coupon_have
(
   user_id              int not null,
   c_code               int not null,
   m_id                 int not null,
   ch_discount          decimal(11,2),
   ch_cnt               int,
   ch_end_date          datetime,
   ch_boolean           int,
   primary key (user_id, c_code, m_id)
);

/*==============================================================*/
/* Table: full_reduction_scheme                                 */
/*==============================================================*/
create table full_reduction_scheme
(
   fr_id                int not null,
   fr_amount            decimal(11,2),
   fr_discount          decimal(11,2),
   fr_conque            int,
   fr_boolean           int,
   primary key (fr_id)
);

/*==============================================================*/
/* Table: merchant                                              */
/*==============================================================*/
create table merchant
(
   m_id                 int not null,
   xq_code              int,
   m_name               varchar(255),
   m_pwd                varchar(255),
   m_level              int,
   per_consumption      decimal(11,2),
   total_sales          decimal(11,2),
   primary key (m_id)
);

/*==============================================================*/
/* Table: order_address                                         */
/*==============================================================*/
create table order_address
(
   oa_id                int not null,
   user_id              int not null,
   oa_province          varchar(50),
   oa_city              varchar(50),
   oa_area              varchar(50),
   oa_address           varchar(255),
   oa_name              varchar(255),
   oa_telephone         varchar(15),
   oa_boolean           varchar(255),
   primary key (oa_id)
);

/*==============================================================*/
/* Table: order_details                                         */
/*==============================================================*/
create table order_details
(
   pd_id                int not null,
   p_id                 int not null,
   od_cnt               int,
   od_price             decimal(11,2),
   od_discount          decimal(11,2),
   primary key (pd_id, p_id)
);

/*==============================================================*/
/* Table: product                                               */
/*==============================================================*/
create table product
(
   p_id                 int not null,
   pc_id                int not null,
   m_id                 int,
   p_name               varchar(255),
   p_price              decimal(11,2),
   p_discount           decimal(11,2),
   p_boolean            int,
   p_cnt                int,
   p_sell               int,
   primary key (p_id)
);

/*==============================================================*/
/* Table: product_category                                      */
/*==============================================================*/
create table product_category
(
   pc_id                int not null,
   m_id                 int,
   pc_name              varchar(255),
   pc_cnt               int,
   pc_boolean           int,
   primary key (pc_id)
);

/*==============================================================*/
/* Table: product_comment                                       */
/*==============================================================*/
create table product_comment
(
   m_id                 int not null,
   user_id              int not null,
   p_id                 int not null,
   pd_id                int not null,
   content              varchar(2555),
   pc_date              datetime,
   pc_level             int,
   photo                longblob,
   primary key (m_id, user_id, p_id, pd_id)
);

/*==============================================================*/
/* Table: product_order                                         */
/*==============================================================*/
create table product_order
(
   pd_id                int not null,
   user_id              int,
   c_code               int,
   fr_id                int,
   oa_id                int,
   m_id                 int,
   po_primary_amount    decimal(11,2),
   po_amount            decimal(11,2),
   po_time              datetime,
   po_order_time        datetime,
   po_actual_time       datetime,
   po_state             int,
   primary key (pd_id)
);

/*==============================================================*/
/* Table: send_coupon                                           */
/*==============================================================*/
create table send_coupon
(
   m_id                 int not null,
   user_id              int not null,
   c_code               int not null,
   sc_order_cnt         int,
   had_order            int,
   primary key (m_id, user_id, c_code)
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   user_id              int not null,
   user_name            varchar(255),
   user_sex             varchar(255),
   user_pwd             varchar(255),
   user_telephone       varchar(15),
   user_email           varchar(255),
   user_start_time      datetime,
   user_vip             int,
   vip_end_date         datetime,
   user_couponcnt       int,
   primary key (user_id)
);

/*==============================================================*/
/* Table: xiaoqu                                                */
/*==============================================================*/
create table xiaoqu
(
   xq_code              int not null,
   xq_name              varchar(255),
   primary key (xq_code)
);

alter table coupon add constraint FK_Relationship_10 foreign key (m_id)
      references merchant (m_id) on delete restrict on update restrict;

alter table coupon_have add constraint FK_coupon_have foreign key (c_code)
      references coupon (c_code) on delete restrict on update restrict;

alter table coupon_have add constraint FK_k2 foreign key (m_id)
      references merchant (m_id) on delete restrict on update restrict;

alter table coupon_have add constraint FK_m2 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table merchant add constraint FK_xqcs foreign key (xq_code)
      references xiaoqu (xq_code) on delete restrict on update restrict;

alter table order_address add constraint FK_add foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table order_details add constraint FK_m4 foreign key (p_id)
      references product (p_id) on delete restrict on update restrict;

alter table order_details add constraint FK_n3 foreign key (pd_id)
      references product_order (pd_id) on delete restrict on update restrict;

alter table product add constraint FK_Relationship_11 foreign key (m_id)
      references merchant (m_id) on delete restrict on update restrict;

alter table product add constraint FK_belong_to foreign key (pc_id)
      references product_category (pc_id) on delete restrict on update restrict;

alter table product_category add constraint FK_fenlei foreign key (m_id)
      references merchant (m_id) on delete restrict on update restrict;

alter table product_comment add constraint FK_m foreign key (p_id)
      references product (p_id) on delete restrict on update restrict;

alter table product_comment add constraint FK_n foreign key (m_id)
      references merchant (m_id) on delete restrict on update restrict;

alter table product_comment add constraint FK_nn foreign key (pd_id)
      references product_order (pd_id) on delete restrict on update restrict;

alter table product_comment add constraint FK_product_comment foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table product_order add constraint FK_arrive foreign key (oa_id)
      references order_address (oa_id) on delete restrict on update restrict;

alter table product_order add constraint FK_buy foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table product_order add constraint FK_fullreduction foreign key (fr_id)
      references full_reduction_scheme (fr_id) on delete restrict on update restrict;

alter table product_order add constraint FK_sell foreign key (m_id)
      references merchant (m_id) on delete restrict on update restrict;

alter table product_order add constraint FK_use foreign key (c_code)
      references coupon (c_code) on delete restrict on update restrict;

alter table send_coupon add constraint FK_k foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table send_coupon add constraint FK_m3 foreign key (m_id)
      references merchant (m_id) on delete restrict on update restrict;

alter table send_coupon add constraint FK_n2 foreign key (c_code)
      references coupon (c_code) on delete restrict on update restrict;

