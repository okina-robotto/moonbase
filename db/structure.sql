SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: amazon_cost_of_goods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.amazon_cost_of_goods (
    id bigint NOT NULL,
    amazon_cost_of_good_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    amazon_marketplace_id bigint,
    sku character varying NOT NULL,
    amount numeric(10,2),
    date_time integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: amazon_cost_of_goods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.amazon_cost_of_goods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: amazon_cost_of_goods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.amazon_cost_of_goods_id_seq OWNED BY public.amazon_cost_of_goods.id;


--
-- Name: amazon_custom_transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.amazon_custom_transactions (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    date_time timestamp without time zone NOT NULL,
    settlement_id bigint NOT NULL,
    amazon_transaction_type_id bigint,
    order_id character varying NOT NULL,
    sku character varying NOT NULL,
    description character varying NOT NULL,
    quantity integer NOT NULL,
    amazon_marketplace_id bigint,
    amazon_fulfillment_id bigint,
    amazon_tax_collection_model_id bigint,
    product_sales numeric(10,2),
    product_sales_tax numeric(10,2),
    shipping_credits numeric(10,2),
    shipping_credits_tax numeric(10,2),
    giftwrap_credits numeric(10,2),
    giftwrap_credits_tax numeric(10,2),
    promotional_rebates numeric(10,2),
    promotional_rebates_tax numeric(10,2),
    marketplace_withheld_tax numeric(10,2),
    selling_fees numeric(10,2),
    fba_fees numeric(10,2),
    other_transaction_fees numeric(10,2),
    other numeric(10,2),
    total numeric(10,2),
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: amazon_custom_transactions_all_time; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_custom_transactions_all_time AS
 SELECT amazon_custom_transactions.user_id,
    date_trunc('month'::text, amazon_custom_transactions.date_time) AS date_time,
    amazon_custom_transactions.amazon_transaction_type_id,
    amazon_custom_transactions.sku,
    sum(amazon_custom_transactions.quantity) AS quantity,
    amazon_custom_transactions.amazon_marketplace_id,
    sum(amazon_custom_transactions.product_sales) AS product_sales,
    sum(amazon_custom_transactions.product_sales_tax) AS product_sales_tax,
    sum(amazon_custom_transactions.shipping_credits) AS shipping_credits,
    sum(amazon_custom_transactions.shipping_credits_tax) AS shipping_credits_tax,
    sum(amazon_custom_transactions.giftwrap_credits) AS giftwrap_credits,
    sum(amazon_custom_transactions.giftwrap_credits_tax) AS giftwrap_credits_tax,
    sum(amazon_custom_transactions.promotional_rebates) AS promotional_rebates,
    sum(amazon_custom_transactions.promotional_rebates_tax) AS promotional_rebates_tax,
    sum(amazon_custom_transactions.marketplace_withheld_tax) AS marketplace_withheld_tax,
    sum(amazon_custom_transactions.selling_fees) AS selling_fees,
    sum(amazon_custom_transactions.fba_fees) AS fba_fees,
    sum(amazon_custom_transactions.other_transaction_fees) AS other_transaction_fees,
    sum(amazon_custom_transactions.other) AS other,
    sum(amazon_custom_transactions.total) AS total
   FROM public.amazon_custom_transactions
  GROUP BY amazon_custom_transactions.user_id, (date_trunc('month'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_transaction_type_id, amazon_custom_transactions.sku, amazon_custom_transactions.amazon_marketplace_id
  ORDER BY (date_trunc('month'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_marketplace_id
  WITH NO DATA;


--
-- Name: amazon_custom_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.amazon_custom_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: amazon_custom_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.amazon_custom_transactions_id_seq OWNED BY public.amazon_custom_transactions.id;


--
-- Name: amazon_custom_transactions_last_month; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_custom_transactions_last_month AS
 SELECT amazon_custom_transactions.user_id,
    date_trunc('day'::text, amazon_custom_transactions.date_time) AS date_time,
    amazon_custom_transactions.amazon_transaction_type_id,
    amazon_custom_transactions.sku,
    sum(amazon_custom_transactions.quantity) AS quantity,
    amazon_custom_transactions.amazon_marketplace_id,
    sum(amazon_custom_transactions.product_sales) AS product_sales,
    sum(amazon_custom_transactions.product_sales_tax) AS product_sales_tax,
    sum(amazon_custom_transactions.shipping_credits) AS shipping_credits,
    sum(amazon_custom_transactions.shipping_credits_tax) AS shipping_credits_tax,
    sum(amazon_custom_transactions.giftwrap_credits) AS giftwrap_credits,
    sum(amazon_custom_transactions.giftwrap_credits_tax) AS giftwrap_credits_tax,
    sum(amazon_custom_transactions.promotional_rebates) AS promotional_rebates,
    sum(amazon_custom_transactions.promotional_rebates_tax) AS promotional_rebates_tax,
    sum(amazon_custom_transactions.marketplace_withheld_tax) AS marketplace_withheld_tax,
    sum(amazon_custom_transactions.selling_fees) AS selling_fees,
    sum(amazon_custom_transactions.fba_fees) AS fba_fees,
    sum(amazon_custom_transactions.other_transaction_fees) AS other_transaction_fees,
    sum(amazon_custom_transactions.other) AS other,
    sum(amazon_custom_transactions.total) AS total
   FROM public.amazon_custom_transactions
  WHERE ((amazon_custom_transactions.date_time >= (date_trunc('month'::text, now()) - '1 mon'::interval)) AND (amazon_custom_transactions.date_time <= (date_trunc('month'::text, now()) - '00:00:01'::interval)))
  GROUP BY amazon_custom_transactions.user_id, (date_trunc('day'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_transaction_type_id, amazon_custom_transactions.sku, amazon_custom_transactions.amazon_marketplace_id
  ORDER BY (date_trunc('day'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_marketplace_id
  WITH NO DATA;


--
-- Name: amazon_custom_transactions_last_six_months; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_custom_transactions_last_six_months AS
 SELECT amazon_custom_transactions.user_id,
    date_trunc('week'::text, amazon_custom_transactions.date_time) AS date_time,
    amazon_custom_transactions.amazon_transaction_type_id,
    amazon_custom_transactions.sku,
    sum(amazon_custom_transactions.quantity) AS quantity,
    amazon_custom_transactions.amazon_marketplace_id,
    sum(amazon_custom_transactions.product_sales) AS product_sales,
    sum(amazon_custom_transactions.product_sales_tax) AS product_sales_tax,
    sum(amazon_custom_transactions.shipping_credits) AS shipping_credits,
    sum(amazon_custom_transactions.shipping_credits_tax) AS shipping_credits_tax,
    sum(amazon_custom_transactions.giftwrap_credits) AS giftwrap_credits,
    sum(amazon_custom_transactions.giftwrap_credits_tax) AS giftwrap_credits_tax,
    sum(amazon_custom_transactions.promotional_rebates) AS promotional_rebates,
    sum(amazon_custom_transactions.promotional_rebates_tax) AS promotional_rebates_tax,
    sum(amazon_custom_transactions.marketplace_withheld_tax) AS marketplace_withheld_tax,
    sum(amazon_custom_transactions.selling_fees) AS selling_fees,
    sum(amazon_custom_transactions.fba_fees) AS fba_fees,
    sum(amazon_custom_transactions.other_transaction_fees) AS other_transaction_fees,
    sum(amazon_custom_transactions.other) AS other,
    sum(amazon_custom_transactions.total) AS total
   FROM public.amazon_custom_transactions
  WHERE ((amazon_custom_transactions.date_time >= (now() - '6 mons'::interval)) AND (amazon_custom_transactions.date_time <= now()))
  GROUP BY amazon_custom_transactions.user_id, (date_trunc('week'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_transaction_type_id, amazon_custom_transactions.sku, amazon_custom_transactions.amazon_marketplace_id
  ORDER BY (date_trunc('week'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_marketplace_id
  WITH NO DATA;


--
-- Name: amazon_custom_transactions_last_thirty_days; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_custom_transactions_last_thirty_days AS
 SELECT amazon_custom_transactions.user_id,
    date_trunc('day'::text, amazon_custom_transactions.date_time) AS date_time,
    amazon_custom_transactions.amazon_transaction_type_id,
    amazon_custom_transactions.sku,
    sum(amazon_custom_transactions.quantity) AS quantity,
    amazon_custom_transactions.amazon_marketplace_id,
    sum(amazon_custom_transactions.product_sales) AS product_sales,
    sum(amazon_custom_transactions.product_sales_tax) AS product_sales_tax,
    sum(amazon_custom_transactions.shipping_credits) AS shipping_credits,
    sum(amazon_custom_transactions.shipping_credits_tax) AS shipping_credits_tax,
    sum(amazon_custom_transactions.giftwrap_credits) AS giftwrap_credits,
    sum(amazon_custom_transactions.giftwrap_credits_tax) AS giftwrap_credits_tax,
    sum(amazon_custom_transactions.promotional_rebates) AS promotional_rebates,
    sum(amazon_custom_transactions.promotional_rebates_tax) AS promotional_rebates_tax,
    sum(amazon_custom_transactions.marketplace_withheld_tax) AS marketplace_withheld_tax,
    sum(amazon_custom_transactions.selling_fees) AS selling_fees,
    sum(amazon_custom_transactions.fba_fees) AS fba_fees,
    sum(amazon_custom_transactions.other_transaction_fees) AS other_transaction_fees,
    sum(amazon_custom_transactions.other) AS other,
    sum(amazon_custom_transactions.total) AS total
   FROM public.amazon_custom_transactions
  WHERE ((amazon_custom_transactions.date_time >= (date_trunc('day'::text, now()) - '30 days'::interval)) AND (amazon_custom_transactions.date_time <= ((date_trunc('day'::text, now()) + '1 day'::interval) - '00:00:01'::interval)))
  GROUP BY amazon_custom_transactions.user_id, (date_trunc('day'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_transaction_type_id, amazon_custom_transactions.sku, amazon_custom_transactions.amazon_marketplace_id
  ORDER BY (date_trunc('day'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_marketplace_id
  WITH NO DATA;


--
-- Name: amazon_custom_transactions_last_three_months; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_custom_transactions_last_three_months AS
 SELECT amazon_custom_transactions.user_id,
    date_trunc('week'::text, amazon_custom_transactions.date_time) AS date_time,
    amazon_custom_transactions.amazon_transaction_type_id,
    amazon_custom_transactions.sku,
    sum(amazon_custom_transactions.quantity) AS quantity,
    amazon_custom_transactions.amazon_marketplace_id,
    sum(amazon_custom_transactions.product_sales) AS product_sales,
    sum(amazon_custom_transactions.product_sales_tax) AS product_sales_tax,
    sum(amazon_custom_transactions.shipping_credits) AS shipping_credits,
    sum(amazon_custom_transactions.shipping_credits_tax) AS shipping_credits_tax,
    sum(amazon_custom_transactions.giftwrap_credits) AS giftwrap_credits,
    sum(amazon_custom_transactions.giftwrap_credits_tax) AS giftwrap_credits_tax,
    sum(amazon_custom_transactions.promotional_rebates) AS promotional_rebates,
    sum(amazon_custom_transactions.promotional_rebates_tax) AS promotional_rebates_tax,
    sum(amazon_custom_transactions.marketplace_withheld_tax) AS marketplace_withheld_tax,
    sum(amazon_custom_transactions.selling_fees) AS selling_fees,
    sum(amazon_custom_transactions.fba_fees) AS fba_fees,
    sum(amazon_custom_transactions.other_transaction_fees) AS other_transaction_fees,
    sum(amazon_custom_transactions.other) AS other,
    sum(amazon_custom_transactions.total) AS total
   FROM public.amazon_custom_transactions
  WHERE ((amazon_custom_transactions.date_time >= (now() - '3 mons'::interval)) AND (amazon_custom_transactions.date_time <= now()))
  GROUP BY amazon_custom_transactions.user_id, (date_trunc('week'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_transaction_type_id, amazon_custom_transactions.sku, amazon_custom_transactions.amazon_marketplace_id
  ORDER BY (date_trunc('week'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_marketplace_id
  WITH NO DATA;


--
-- Name: amazon_custom_transactions_last_year; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_custom_transactions_last_year AS
 SELECT amazon_custom_transactions.user_id,
    date_trunc('week'::text, amazon_custom_transactions.date_time) AS date_time,
    amazon_custom_transactions.amazon_transaction_type_id,
    amazon_custom_transactions.sku,
    sum(amazon_custom_transactions.quantity) AS quantity,
    amazon_custom_transactions.amazon_marketplace_id,
    sum(amazon_custom_transactions.product_sales) AS product_sales,
    sum(amazon_custom_transactions.product_sales_tax) AS product_sales_tax,
    sum(amazon_custom_transactions.shipping_credits) AS shipping_credits,
    sum(amazon_custom_transactions.shipping_credits_tax) AS shipping_credits_tax,
    sum(amazon_custom_transactions.giftwrap_credits) AS giftwrap_credits,
    sum(amazon_custom_transactions.giftwrap_credits_tax) AS giftwrap_credits_tax,
    sum(amazon_custom_transactions.promotional_rebates) AS promotional_rebates,
    sum(amazon_custom_transactions.promotional_rebates_tax) AS promotional_rebates_tax,
    sum(amazon_custom_transactions.marketplace_withheld_tax) AS marketplace_withheld_tax,
    sum(amazon_custom_transactions.selling_fees) AS selling_fees,
    sum(amazon_custom_transactions.fba_fees) AS fba_fees,
    sum(amazon_custom_transactions.other_transaction_fees) AS other_transaction_fees,
    sum(amazon_custom_transactions.other) AS other,
    sum(amazon_custom_transactions.total) AS total
   FROM public.amazon_custom_transactions
  WHERE ((amazon_custom_transactions.date_time >= (date_trunc('year'::text, now()) - '1 year'::interval)) AND (amazon_custom_transactions.date_time <= (date_trunc('year'::text, now()) - '00:00:01'::interval)))
  GROUP BY amazon_custom_transactions.user_id, (date_trunc('week'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_transaction_type_id, amazon_custom_transactions.sku, amazon_custom_transactions.amazon_marketplace_id
  ORDER BY (date_trunc('week'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_marketplace_id
  WITH NO DATA;


--
-- Name: amazon_custom_transactions_month_before_last; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_custom_transactions_month_before_last AS
 SELECT amazon_custom_transactions.user_id,
    date_trunc('day'::text, amazon_custom_transactions.date_time) AS date_time,
    amazon_custom_transactions.amazon_transaction_type_id,
    amazon_custom_transactions.sku,
    sum(amazon_custom_transactions.quantity) AS quantity,
    amazon_custom_transactions.amazon_marketplace_id,
    sum(amazon_custom_transactions.product_sales) AS product_sales,
    sum(amazon_custom_transactions.product_sales_tax) AS product_sales_tax,
    sum(amazon_custom_transactions.shipping_credits) AS shipping_credits,
    sum(amazon_custom_transactions.shipping_credits_tax) AS shipping_credits_tax,
    sum(amazon_custom_transactions.giftwrap_credits) AS giftwrap_credits,
    sum(amazon_custom_transactions.giftwrap_credits_tax) AS giftwrap_credits_tax,
    sum(amazon_custom_transactions.promotional_rebates) AS promotional_rebates,
    sum(amazon_custom_transactions.promotional_rebates_tax) AS promotional_rebates_tax,
    sum(amazon_custom_transactions.marketplace_withheld_tax) AS marketplace_withheld_tax,
    sum(amazon_custom_transactions.selling_fees) AS selling_fees,
    sum(amazon_custom_transactions.fba_fees) AS fba_fees,
    sum(amazon_custom_transactions.other_transaction_fees) AS other_transaction_fees,
    sum(amazon_custom_transactions.other) AS other,
    sum(amazon_custom_transactions.total) AS total
   FROM public.amazon_custom_transactions
  WHERE ((amazon_custom_transactions.date_time >= (date_trunc('month'::text, now()) - '2 mons'::interval)) AND (amazon_custom_transactions.date_time <= ((date_trunc('month'::text, now()) - '1 mon'::interval) - '00:00:01'::interval)))
  GROUP BY amazon_custom_transactions.user_id, (date_trunc('day'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_transaction_type_id, amazon_custom_transactions.sku, amazon_custom_transactions.amazon_marketplace_id
  ORDER BY (date_trunc('day'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_marketplace_id
  WITH NO DATA;


--
-- Name: amazon_custom_transactions_previous_six_months; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_custom_transactions_previous_six_months AS
 SELECT amazon_custom_transactions.user_id,
    date_trunc('week'::text, amazon_custom_transactions.date_time) AS date_time,
    amazon_custom_transactions.amazon_transaction_type_id,
    amazon_custom_transactions.sku,
    sum(amazon_custom_transactions.quantity) AS quantity,
    amazon_custom_transactions.amazon_marketplace_id,
    sum(amazon_custom_transactions.product_sales) AS product_sales,
    sum(amazon_custom_transactions.product_sales_tax) AS product_sales_tax,
    sum(amazon_custom_transactions.shipping_credits) AS shipping_credits,
    sum(amazon_custom_transactions.shipping_credits_tax) AS shipping_credits_tax,
    sum(amazon_custom_transactions.giftwrap_credits) AS giftwrap_credits,
    sum(amazon_custom_transactions.giftwrap_credits_tax) AS giftwrap_credits_tax,
    sum(amazon_custom_transactions.promotional_rebates) AS promotional_rebates,
    sum(amazon_custom_transactions.promotional_rebates_tax) AS promotional_rebates_tax,
    sum(amazon_custom_transactions.marketplace_withheld_tax) AS marketplace_withheld_tax,
    sum(amazon_custom_transactions.selling_fees) AS selling_fees,
    sum(amazon_custom_transactions.fba_fees) AS fba_fees,
    sum(amazon_custom_transactions.other_transaction_fees) AS other_transaction_fees,
    sum(amazon_custom_transactions.other) AS other,
    sum(amazon_custom_transactions.total) AS total
   FROM public.amazon_custom_transactions
  WHERE ((amazon_custom_transactions.date_time >= (now() - '1 year'::interval)) AND (amazon_custom_transactions.date_time <= (now() - '6 mons'::interval)))
  GROUP BY amazon_custom_transactions.user_id, (date_trunc('week'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_transaction_type_id, amazon_custom_transactions.sku, amazon_custom_transactions.amazon_marketplace_id
  ORDER BY (date_trunc('week'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_marketplace_id
  WITH NO DATA;


--
-- Name: amazon_custom_transactions_previous_thirty_days; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_custom_transactions_previous_thirty_days AS
 SELECT amazon_custom_transactions.user_id,
    date_trunc('day'::text, amazon_custom_transactions.date_time) AS date_time,
    amazon_custom_transactions.amazon_transaction_type_id,
    amazon_custom_transactions.sku,
    sum(amazon_custom_transactions.quantity) AS quantity,
    amazon_custom_transactions.amazon_marketplace_id,
    sum(amazon_custom_transactions.product_sales) AS product_sales,
    sum(amazon_custom_transactions.product_sales_tax) AS product_sales_tax,
    sum(amazon_custom_transactions.shipping_credits) AS shipping_credits,
    sum(amazon_custom_transactions.shipping_credits_tax) AS shipping_credits_tax,
    sum(amazon_custom_transactions.giftwrap_credits) AS giftwrap_credits,
    sum(amazon_custom_transactions.giftwrap_credits_tax) AS giftwrap_credits_tax,
    sum(amazon_custom_transactions.promotional_rebates) AS promotional_rebates,
    sum(amazon_custom_transactions.promotional_rebates_tax) AS promotional_rebates_tax,
    sum(amazon_custom_transactions.marketplace_withheld_tax) AS marketplace_withheld_tax,
    sum(amazon_custom_transactions.selling_fees) AS selling_fees,
    sum(amazon_custom_transactions.fba_fees) AS fba_fees,
    sum(amazon_custom_transactions.other_transaction_fees) AS other_transaction_fees,
    sum(amazon_custom_transactions.other) AS other,
    sum(amazon_custom_transactions.total) AS total
   FROM public.amazon_custom_transactions
  WHERE ((amazon_custom_transactions.date_time >= (date_trunc('day'::text, now()) - '60 days'::interval)) AND (amazon_custom_transactions.date_time <= ((date_trunc('day'::text, now()) - '30 days'::interval) - '00:00:01'::interval)))
  GROUP BY amazon_custom_transactions.user_id, (date_trunc('day'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_transaction_type_id, amazon_custom_transactions.sku, amazon_custom_transactions.amazon_marketplace_id
  ORDER BY (date_trunc('day'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_marketplace_id
  WITH NO DATA;


--
-- Name: amazon_custom_transactions_previous_three_months; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_custom_transactions_previous_three_months AS
 SELECT amazon_custom_transactions.user_id,
    date_trunc('week'::text, amazon_custom_transactions.date_time) AS date_time,
    amazon_custom_transactions.amazon_transaction_type_id,
    amazon_custom_transactions.sku,
    sum(amazon_custom_transactions.quantity) AS quantity,
    amazon_custom_transactions.amazon_marketplace_id,
    sum(amazon_custom_transactions.product_sales) AS product_sales,
    sum(amazon_custom_transactions.product_sales_tax) AS product_sales_tax,
    sum(amazon_custom_transactions.shipping_credits) AS shipping_credits,
    sum(amazon_custom_transactions.shipping_credits_tax) AS shipping_credits_tax,
    sum(amazon_custom_transactions.giftwrap_credits) AS giftwrap_credits,
    sum(amazon_custom_transactions.giftwrap_credits_tax) AS giftwrap_credits_tax,
    sum(amazon_custom_transactions.promotional_rebates) AS promotional_rebates,
    sum(amazon_custom_transactions.promotional_rebates_tax) AS promotional_rebates_tax,
    sum(amazon_custom_transactions.marketplace_withheld_tax) AS marketplace_withheld_tax,
    sum(amazon_custom_transactions.selling_fees) AS selling_fees,
    sum(amazon_custom_transactions.fba_fees) AS fba_fees,
    sum(amazon_custom_transactions.other_transaction_fees) AS other_transaction_fees,
    sum(amazon_custom_transactions.other) AS other,
    sum(amazon_custom_transactions.total) AS total
   FROM public.amazon_custom_transactions
  WHERE ((amazon_custom_transactions.date_time >= (now() - '6 mons'::interval)) AND (amazon_custom_transactions.date_time <= (now() - '3 mons'::interval)))
  GROUP BY amazon_custom_transactions.user_id, (date_trunc('week'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_transaction_type_id, amazon_custom_transactions.sku, amazon_custom_transactions.amazon_marketplace_id
  ORDER BY (date_trunc('week'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_marketplace_id
  WITH NO DATA;


--
-- Name: amazon_custom_transactions_this_month; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_custom_transactions_this_month AS
 SELECT amazon_custom_transactions.user_id,
    date_trunc('day'::text, amazon_custom_transactions.date_time) AS date_time,
    amazon_custom_transactions.amazon_transaction_type_id,
    amazon_custom_transactions.sku,
    sum(amazon_custom_transactions.quantity) AS quantity,
    amazon_custom_transactions.amazon_marketplace_id,
    sum(amazon_custom_transactions.product_sales) AS product_sales,
    sum(amazon_custom_transactions.product_sales_tax) AS product_sales_tax,
    sum(amazon_custom_transactions.shipping_credits) AS shipping_credits,
    sum(amazon_custom_transactions.shipping_credits_tax) AS shipping_credits_tax,
    sum(amazon_custom_transactions.giftwrap_credits) AS giftwrap_credits,
    sum(amazon_custom_transactions.giftwrap_credits_tax) AS giftwrap_credits_tax,
    sum(amazon_custom_transactions.promotional_rebates) AS promotional_rebates,
    sum(amazon_custom_transactions.promotional_rebates_tax) AS promotional_rebates_tax,
    sum(amazon_custom_transactions.marketplace_withheld_tax) AS marketplace_withheld_tax,
    sum(amazon_custom_transactions.selling_fees) AS selling_fees,
    sum(amazon_custom_transactions.fba_fees) AS fba_fees,
    sum(amazon_custom_transactions.other_transaction_fees) AS other_transaction_fees,
    sum(amazon_custom_transactions.other) AS other,
    sum(amazon_custom_transactions.total) AS total
   FROM public.amazon_custom_transactions
  WHERE ((amazon_custom_transactions.date_time >= date_trunc('month'::text, now())) AND (amazon_custom_transactions.date_time <= ((date_trunc('month'::text, now()) + '1 mon'::interval) - '00:00:01'::interval)))
  GROUP BY amazon_custom_transactions.user_id, (date_trunc('day'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_transaction_type_id, amazon_custom_transactions.sku, amazon_custom_transactions.amazon_marketplace_id
  ORDER BY (date_trunc('day'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_marketplace_id
  WITH NO DATA;


--
-- Name: amazon_custom_transactions_this_year; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_custom_transactions_this_year AS
 SELECT amazon_custom_transactions.user_id,
    date_trunc('week'::text, amazon_custom_transactions.date_time) AS date_time,
    amazon_custom_transactions.amazon_transaction_type_id,
    amazon_custom_transactions.sku,
    sum(amazon_custom_transactions.quantity) AS quantity,
    amazon_custom_transactions.amazon_marketplace_id,
    sum(amazon_custom_transactions.product_sales) AS product_sales,
    sum(amazon_custom_transactions.product_sales_tax) AS product_sales_tax,
    sum(amazon_custom_transactions.shipping_credits) AS shipping_credits,
    sum(amazon_custom_transactions.shipping_credits_tax) AS shipping_credits_tax,
    sum(amazon_custom_transactions.giftwrap_credits) AS giftwrap_credits,
    sum(amazon_custom_transactions.giftwrap_credits_tax) AS giftwrap_credits_tax,
    sum(amazon_custom_transactions.promotional_rebates) AS promotional_rebates,
    sum(amazon_custom_transactions.promotional_rebates_tax) AS promotional_rebates_tax,
    sum(amazon_custom_transactions.marketplace_withheld_tax) AS marketplace_withheld_tax,
    sum(amazon_custom_transactions.selling_fees) AS selling_fees,
    sum(amazon_custom_transactions.fba_fees) AS fba_fees,
    sum(amazon_custom_transactions.other_transaction_fees) AS other_transaction_fees,
    sum(amazon_custom_transactions.other) AS other,
    sum(amazon_custom_transactions.total) AS total
   FROM public.amazon_custom_transactions
  WHERE ((amazon_custom_transactions.date_time >= date_trunc('year'::text, now())) AND (amazon_custom_transactions.date_time <= now()))
  GROUP BY amazon_custom_transactions.user_id, (date_trunc('week'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_transaction_type_id, amazon_custom_transactions.sku, amazon_custom_transactions.amazon_marketplace_id
  ORDER BY (date_trunc('week'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_marketplace_id
  WITH NO DATA;


--
-- Name: amazon_custom_transactions_today; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_custom_transactions_today AS
 SELECT amazon_custom_transactions.user_id,
    date_trunc('hour'::text, amazon_custom_transactions.date_time) AS date_time,
    amazon_custom_transactions.amazon_transaction_type_id,
    amazon_custom_transactions.sku,
    sum(amazon_custom_transactions.quantity) AS quantity,
    amazon_custom_transactions.amazon_marketplace_id,
    sum(amazon_custom_transactions.product_sales) AS product_sales,
    sum(amazon_custom_transactions.product_sales_tax) AS product_sales_tax,
    sum(amazon_custom_transactions.shipping_credits) AS shipping_credits,
    sum(amazon_custom_transactions.shipping_credits_tax) AS shipping_credits_tax,
    sum(amazon_custom_transactions.giftwrap_credits) AS giftwrap_credits,
    sum(amazon_custom_transactions.giftwrap_credits_tax) AS giftwrap_credits_tax,
    sum(amazon_custom_transactions.promotional_rebates) AS promotional_rebates,
    sum(amazon_custom_transactions.promotional_rebates_tax) AS promotional_rebates_tax,
    sum(amazon_custom_transactions.marketplace_withheld_tax) AS marketplace_withheld_tax,
    sum(amazon_custom_transactions.selling_fees) AS selling_fees,
    sum(amazon_custom_transactions.fba_fees) AS fba_fees,
    sum(amazon_custom_transactions.other_transaction_fees) AS other_transaction_fees,
    sum(amazon_custom_transactions.other) AS other,
    sum(amazon_custom_transactions.total) AS total
   FROM public.amazon_custom_transactions
  WHERE ((amazon_custom_transactions.date_time >= date_trunc('day'::text, now())) AND (amazon_custom_transactions.date_time <= ((date_trunc('day'::text, now()) + '1 day'::interval) - '00:00:01'::interval)))
  GROUP BY amazon_custom_transactions.user_id, (date_trunc('hour'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_transaction_type_id, amazon_custom_transactions.sku, amazon_custom_transactions.amazon_marketplace_id
  ORDER BY (date_trunc('hour'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_marketplace_id
  WITH NO DATA;


--
-- Name: amazon_custom_transactions_yesterday; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_custom_transactions_yesterday AS
 SELECT amazon_custom_transactions.user_id,
    date_trunc('hour'::text, amazon_custom_transactions.date_time) AS date_time,
    amazon_custom_transactions.amazon_transaction_type_id,
    amazon_custom_transactions.sku,
    sum(amazon_custom_transactions.quantity) AS quantity,
    amazon_custom_transactions.amazon_marketplace_id,
    sum(amazon_custom_transactions.product_sales) AS product_sales,
    sum(amazon_custom_transactions.product_sales_tax) AS product_sales_tax,
    sum(amazon_custom_transactions.shipping_credits) AS shipping_credits,
    sum(amazon_custom_transactions.shipping_credits_tax) AS shipping_credits_tax,
    sum(amazon_custom_transactions.giftwrap_credits) AS giftwrap_credits,
    sum(amazon_custom_transactions.giftwrap_credits_tax) AS giftwrap_credits_tax,
    sum(amazon_custom_transactions.promotional_rebates) AS promotional_rebates,
    sum(amazon_custom_transactions.promotional_rebates_tax) AS promotional_rebates_tax,
    sum(amazon_custom_transactions.marketplace_withheld_tax) AS marketplace_withheld_tax,
    sum(amazon_custom_transactions.selling_fees) AS selling_fees,
    sum(amazon_custom_transactions.fba_fees) AS fba_fees,
    sum(amazon_custom_transactions.other_transaction_fees) AS other_transaction_fees,
    sum(amazon_custom_transactions.other) AS other,
    sum(amazon_custom_transactions.total) AS total
   FROM public.amazon_custom_transactions
  WHERE ((amazon_custom_transactions.date_time >= (date_trunc('day'::text, now()) - '1 day'::interval)) AND (amazon_custom_transactions.date_time <= (date_trunc('day'::text, now()) - '00:00:01'::interval)))
  GROUP BY amazon_custom_transactions.user_id, (date_trunc('hour'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_transaction_type_id, amazon_custom_transactions.sku, amazon_custom_transactions.amazon_marketplace_id
  ORDER BY (date_trunc('hour'::text, amazon_custom_transactions.date_time)), amazon_custom_transactions.amazon_marketplace_id
  WITH NO DATA;


--
-- Name: amazon_fulfillments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.amazon_fulfillments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: amazon_fulfillments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.amazon_fulfillments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: amazon_fulfillments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.amazon_fulfillments_id_seq OWNED BY public.amazon_fulfillments.id;


--
-- Name: amazon_marketplaces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.amazon_marketplaces (
    id bigint NOT NULL,
    amazon_marketplace_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    currency_exchange_rate_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: amazon_marketplaces_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.amazon_marketplaces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: amazon_marketplaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.amazon_marketplaces_id_seq OWNED BY public.amazon_marketplaces.id;


--
-- Name: amazon_transaction_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.amazon_transaction_types (
    id bigint NOT NULL,
    name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: amazon_products; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_products AS
 SELECT DISTINCT t.sku,
    t.user_id,
    t.description,
    m.name AS marketplace
   FROM ((public.amazon_custom_transactions t
     LEFT JOIN public.amazon_marketplaces m ON ((t.amazon_marketplace_id = m.id)))
     LEFT JOIN public.amazon_transaction_types tt ON ((t.amazon_transaction_type_id = tt.id)))
  WHERE ((tt.name)::text = 'Order'::text)
  GROUP BY t.sku, t.user_id, t.description, m.name
  WITH NO DATA;


--
-- Name: amazon_sponsored_products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.amazon_sponsored_products (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    date_time timestamp without time zone NOT NULL,
    portfolio_name character varying NOT NULL,
    currency_exchange_rate_id bigint,
    campaign_name character varying NOT NULL,
    ad_group_name character varying NOT NULL,
    sku character varying NOT NULL,
    asin character varying NOT NULL,
    impressions integer,
    clicks integer,
    ctr numeric(10,2),
    cpc numeric(10,2),
    spend numeric(10,2),
    total_sales numeric(10,2),
    acos numeric(10,2),
    roas numeric(10,2),
    total_orders integer,
    total_units integer,
    conversion_rate numeric(10,2),
    advertised_sku_units integer,
    other_sku_units integer,
    advertised_sku_sales numeric(10,2),
    other_sku_sales numeric(10,2),
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: amazon_sponsored_products_all_time; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_sponsored_products_all_time AS
 SELECT amazon_sponsored_products.user_id,
    date_trunc('month'::text, amazon_sponsored_products.date_time) AS date_time,
    amazon_sponsored_products.portfolio_name,
    amazon_sponsored_products.currency_exchange_rate_id,
    amazon_sponsored_products.campaign_name,
    amazon_sponsored_products.ad_group_name,
    amazon_sponsored_products.sku,
    amazon_sponsored_products.asin,
    sum(amazon_sponsored_products.impressions) AS impressions,
    sum(amazon_sponsored_products.clicks) AS clicks,
    sum(amazon_sponsored_products.ctr) AS ctr,
    sum(amazon_sponsored_products.cpc) AS cpc,
    sum(amazon_sponsored_products.spend) AS spend,
    sum(amazon_sponsored_products.total_sales) AS total_sales,
    sum(amazon_sponsored_products.acos) AS acos,
    sum(amazon_sponsored_products.roas) AS roas,
    sum(amazon_sponsored_products.total_orders) AS total_orders,
    sum(amazon_sponsored_products.total_units) AS total_units,
    avg(amazon_sponsored_products.conversion_rate) AS conversion_rate,
    sum(amazon_sponsored_products.advertised_sku_units) AS advertised_sku_units,
    sum(amazon_sponsored_products.other_sku_units) AS other_sku_units,
    sum(amazon_sponsored_products.advertised_sku_sales) AS advertised_sku_sales,
    sum(amazon_sponsored_products.other_sku_sales) AS other_sku_sales
   FROM public.amazon_sponsored_products
  GROUP BY amazon_sponsored_products.user_id, (date_trunc('month'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.portfolio_name, amazon_sponsored_products.currency_exchange_rate_id, amazon_sponsored_products.campaign_name, amazon_sponsored_products.ad_group_name, amazon_sponsored_products.sku, amazon_sponsored_products.asin
  ORDER BY (date_trunc('month'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.currency_exchange_rate_id
  WITH NO DATA;


--
-- Name: amazon_sponsored_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.amazon_sponsored_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: amazon_sponsored_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.amazon_sponsored_products_id_seq OWNED BY public.amazon_sponsored_products.id;


--
-- Name: amazon_sponsored_products_last_month; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_sponsored_products_last_month AS
 SELECT amazon_sponsored_products.user_id,
    date_trunc('day'::text, amazon_sponsored_products.date_time) AS date_time,
    amazon_sponsored_products.portfolio_name,
    amazon_sponsored_products.currency_exchange_rate_id,
    amazon_sponsored_products.campaign_name,
    amazon_sponsored_products.ad_group_name,
    amazon_sponsored_products.sku,
    amazon_sponsored_products.asin,
    sum(amazon_sponsored_products.impressions) AS impressions,
    sum(amazon_sponsored_products.clicks) AS clicks,
    sum(amazon_sponsored_products.ctr) AS ctr,
    sum(amazon_sponsored_products.cpc) AS cpc,
    sum(amazon_sponsored_products.spend) AS spend,
    sum(amazon_sponsored_products.total_sales) AS total_sales,
    sum(amazon_sponsored_products.acos) AS acos,
    sum(amazon_sponsored_products.roas) AS roas,
    sum(amazon_sponsored_products.total_orders) AS total_orders,
    sum(amazon_sponsored_products.total_units) AS total_units,
    avg(amazon_sponsored_products.conversion_rate) AS conversion_rate,
    sum(amazon_sponsored_products.advertised_sku_units) AS advertised_sku_units,
    sum(amazon_sponsored_products.other_sku_units) AS other_sku_units,
    sum(amazon_sponsored_products.advertised_sku_sales) AS advertised_sku_sales,
    sum(amazon_sponsored_products.other_sku_sales) AS other_sku_sales
   FROM public.amazon_sponsored_products
  WHERE ((amazon_sponsored_products.date_time >= (date_trunc('month'::text, now()) - '1 mon'::interval)) AND (amazon_sponsored_products.date_time <= (date_trunc('month'::text, now()) - '00:00:01'::interval)))
  GROUP BY amazon_sponsored_products.user_id, (date_trunc('day'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.portfolio_name, amazon_sponsored_products.currency_exchange_rate_id, amazon_sponsored_products.campaign_name, amazon_sponsored_products.ad_group_name, amazon_sponsored_products.sku, amazon_sponsored_products.asin
  ORDER BY (date_trunc('day'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.currency_exchange_rate_id
  WITH NO DATA;


--
-- Name: amazon_sponsored_products_last_six_months; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_sponsored_products_last_six_months AS
 SELECT amazon_sponsored_products.user_id,
    date_trunc('week'::text, amazon_sponsored_products.date_time) AS date_time,
    amazon_sponsored_products.portfolio_name,
    amazon_sponsored_products.currency_exchange_rate_id,
    amazon_sponsored_products.campaign_name,
    amazon_sponsored_products.ad_group_name,
    amazon_sponsored_products.sku,
    amazon_sponsored_products.asin,
    sum(amazon_sponsored_products.impressions) AS impressions,
    sum(amazon_sponsored_products.clicks) AS clicks,
    sum(amazon_sponsored_products.ctr) AS ctr,
    sum(amazon_sponsored_products.cpc) AS cpc,
    sum(amazon_sponsored_products.spend) AS spend,
    sum(amazon_sponsored_products.total_sales) AS total_sales,
    sum(amazon_sponsored_products.acos) AS acos,
    sum(amazon_sponsored_products.roas) AS roas,
    sum(amazon_sponsored_products.total_orders) AS total_orders,
    sum(amazon_sponsored_products.total_units) AS total_units,
    avg(amazon_sponsored_products.conversion_rate) AS conversion_rate,
    sum(amazon_sponsored_products.advertised_sku_units) AS advertised_sku_units,
    sum(amazon_sponsored_products.other_sku_units) AS other_sku_units,
    sum(amazon_sponsored_products.advertised_sku_sales) AS advertised_sku_sales,
    sum(amazon_sponsored_products.other_sku_sales) AS other_sku_sales
   FROM public.amazon_sponsored_products
  WHERE ((amazon_sponsored_products.date_time >= (now() - '6 mons'::interval)) AND (amazon_sponsored_products.date_time <= now()))
  GROUP BY amazon_sponsored_products.user_id, (date_trunc('week'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.portfolio_name, amazon_sponsored_products.currency_exchange_rate_id, amazon_sponsored_products.campaign_name, amazon_sponsored_products.ad_group_name, amazon_sponsored_products.sku, amazon_sponsored_products.asin
  ORDER BY (date_trunc('week'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.currency_exchange_rate_id
  WITH NO DATA;


--
-- Name: amazon_sponsored_products_last_thirty_days; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_sponsored_products_last_thirty_days AS
 SELECT amazon_sponsored_products.user_id,
    date_trunc('day'::text, amazon_sponsored_products.date_time) AS date_time,
    amazon_sponsored_products.portfolio_name,
    amazon_sponsored_products.currency_exchange_rate_id,
    amazon_sponsored_products.campaign_name,
    amazon_sponsored_products.ad_group_name,
    amazon_sponsored_products.sku,
    amazon_sponsored_products.asin,
    sum(amazon_sponsored_products.impressions) AS impressions,
    sum(amazon_sponsored_products.clicks) AS clicks,
    sum(amazon_sponsored_products.ctr) AS ctr,
    sum(amazon_sponsored_products.cpc) AS cpc,
    sum(amazon_sponsored_products.spend) AS spend,
    sum(amazon_sponsored_products.total_sales) AS total_sales,
    sum(amazon_sponsored_products.acos) AS acos,
    sum(amazon_sponsored_products.roas) AS roas,
    sum(amazon_sponsored_products.total_orders) AS total_orders,
    sum(amazon_sponsored_products.total_units) AS total_units,
    avg(amazon_sponsored_products.conversion_rate) AS conversion_rate,
    sum(amazon_sponsored_products.advertised_sku_units) AS advertised_sku_units,
    sum(amazon_sponsored_products.other_sku_units) AS other_sku_units,
    sum(amazon_sponsored_products.advertised_sku_sales) AS advertised_sku_sales,
    sum(amazon_sponsored_products.other_sku_sales) AS other_sku_sales
   FROM public.amazon_sponsored_products
  WHERE ((amazon_sponsored_products.date_time >= (date_trunc('day'::text, now()) - '30 days'::interval)) AND (amazon_sponsored_products.date_time <= ((date_trunc('day'::text, now()) + '1 day'::interval) - '00:00:01'::interval)))
  GROUP BY amazon_sponsored_products.user_id, (date_trunc('day'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.portfolio_name, amazon_sponsored_products.currency_exchange_rate_id, amazon_sponsored_products.campaign_name, amazon_sponsored_products.ad_group_name, amazon_sponsored_products.sku, amazon_sponsored_products.asin
  ORDER BY (date_trunc('day'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.currency_exchange_rate_id
  WITH NO DATA;


--
-- Name: amazon_sponsored_products_last_three_months; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_sponsored_products_last_three_months AS
 SELECT amazon_sponsored_products.user_id,
    date_trunc('week'::text, amazon_sponsored_products.date_time) AS date_time,
    amazon_sponsored_products.portfolio_name,
    amazon_sponsored_products.currency_exchange_rate_id,
    amazon_sponsored_products.campaign_name,
    amazon_sponsored_products.ad_group_name,
    amazon_sponsored_products.sku,
    amazon_sponsored_products.asin,
    sum(amazon_sponsored_products.impressions) AS impressions,
    sum(amazon_sponsored_products.clicks) AS clicks,
    sum(amazon_sponsored_products.ctr) AS ctr,
    sum(amazon_sponsored_products.cpc) AS cpc,
    sum(amazon_sponsored_products.spend) AS spend,
    sum(amazon_sponsored_products.total_sales) AS total_sales,
    sum(amazon_sponsored_products.acos) AS acos,
    sum(amazon_sponsored_products.roas) AS roas,
    sum(amazon_sponsored_products.total_orders) AS total_orders,
    sum(amazon_sponsored_products.total_units) AS total_units,
    avg(amazon_sponsored_products.conversion_rate) AS conversion_rate,
    sum(amazon_sponsored_products.advertised_sku_units) AS advertised_sku_units,
    sum(amazon_sponsored_products.other_sku_units) AS other_sku_units,
    sum(amazon_sponsored_products.advertised_sku_sales) AS advertised_sku_sales,
    sum(amazon_sponsored_products.other_sku_sales) AS other_sku_sales
   FROM public.amazon_sponsored_products
  WHERE ((amazon_sponsored_products.date_time >= (now() - '3 mons'::interval)) AND (amazon_sponsored_products.date_time <= now()))
  GROUP BY amazon_sponsored_products.user_id, (date_trunc('week'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.portfolio_name, amazon_sponsored_products.currency_exchange_rate_id, amazon_sponsored_products.campaign_name, amazon_sponsored_products.ad_group_name, amazon_sponsored_products.sku, amazon_sponsored_products.asin
  ORDER BY (date_trunc('week'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.currency_exchange_rate_id
  WITH NO DATA;


--
-- Name: amazon_sponsored_products_last_year; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_sponsored_products_last_year AS
 SELECT amazon_sponsored_products.user_id,
    date_trunc('week'::text, amazon_sponsored_products.date_time) AS date_time,
    amazon_sponsored_products.portfolio_name,
    amazon_sponsored_products.currency_exchange_rate_id,
    amazon_sponsored_products.campaign_name,
    amazon_sponsored_products.ad_group_name,
    amazon_sponsored_products.sku,
    amazon_sponsored_products.asin,
    sum(amazon_sponsored_products.impressions) AS impressions,
    sum(amazon_sponsored_products.clicks) AS clicks,
    sum(amazon_sponsored_products.ctr) AS ctr,
    sum(amazon_sponsored_products.cpc) AS cpc,
    sum(amazon_sponsored_products.spend) AS spend,
    sum(amazon_sponsored_products.total_sales) AS total_sales,
    sum(amazon_sponsored_products.acos) AS acos,
    sum(amazon_sponsored_products.roas) AS roas,
    sum(amazon_sponsored_products.total_orders) AS total_orders,
    sum(amazon_sponsored_products.total_units) AS total_units,
    avg(amazon_sponsored_products.conversion_rate) AS conversion_rate,
    sum(amazon_sponsored_products.advertised_sku_units) AS advertised_sku_units,
    sum(amazon_sponsored_products.other_sku_units) AS other_sku_units,
    sum(amazon_sponsored_products.advertised_sku_sales) AS advertised_sku_sales,
    sum(amazon_sponsored_products.other_sku_sales) AS other_sku_sales
   FROM public.amazon_sponsored_products
  WHERE ((amazon_sponsored_products.date_time >= (date_trunc('year'::text, now()) - '1 year'::interval)) AND (amazon_sponsored_products.date_time <= (date_trunc('year'::text, now()) - '00:00:01'::interval)))
  GROUP BY amazon_sponsored_products.user_id, (date_trunc('week'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.portfolio_name, amazon_sponsored_products.currency_exchange_rate_id, amazon_sponsored_products.campaign_name, amazon_sponsored_products.ad_group_name, amazon_sponsored_products.sku, amazon_sponsored_products.asin
  ORDER BY (date_trunc('week'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.currency_exchange_rate_id
  WITH NO DATA;


--
-- Name: amazon_sponsored_products_month_before_last; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_sponsored_products_month_before_last AS
 SELECT amazon_sponsored_products.user_id,
    date_trunc('day'::text, amazon_sponsored_products.date_time) AS date_time,
    amazon_sponsored_products.portfolio_name,
    amazon_sponsored_products.currency_exchange_rate_id,
    amazon_sponsored_products.campaign_name,
    amazon_sponsored_products.ad_group_name,
    amazon_sponsored_products.sku,
    amazon_sponsored_products.asin,
    sum(amazon_sponsored_products.impressions) AS impressions,
    sum(amazon_sponsored_products.clicks) AS clicks,
    sum(amazon_sponsored_products.ctr) AS ctr,
    sum(amazon_sponsored_products.cpc) AS cpc,
    sum(amazon_sponsored_products.spend) AS spend,
    sum(amazon_sponsored_products.total_sales) AS total_sales,
    sum(amazon_sponsored_products.acos) AS acos,
    sum(amazon_sponsored_products.roas) AS roas,
    sum(amazon_sponsored_products.total_orders) AS total_orders,
    sum(amazon_sponsored_products.total_units) AS total_units,
    avg(amazon_sponsored_products.conversion_rate) AS conversion_rate,
    sum(amazon_sponsored_products.advertised_sku_units) AS advertised_sku_units,
    sum(amazon_sponsored_products.other_sku_units) AS other_sku_units,
    sum(amazon_sponsored_products.advertised_sku_sales) AS advertised_sku_sales,
    sum(amazon_sponsored_products.other_sku_sales) AS other_sku_sales
   FROM public.amazon_sponsored_products
  WHERE ((amazon_sponsored_products.date_time >= (date_trunc('month'::text, now()) - '2 mons'::interval)) AND (amazon_sponsored_products.date_time <= ((date_trunc('month'::text, now()) - '1 mon'::interval) - '00:00:01'::interval)))
  GROUP BY amazon_sponsored_products.user_id, (date_trunc('day'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.portfolio_name, amazon_sponsored_products.currency_exchange_rate_id, amazon_sponsored_products.campaign_name, amazon_sponsored_products.ad_group_name, amazon_sponsored_products.sku, amazon_sponsored_products.asin
  ORDER BY (date_trunc('day'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.currency_exchange_rate_id
  WITH NO DATA;


--
-- Name: amazon_sponsored_products_previous_six_months; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_sponsored_products_previous_six_months AS
 SELECT amazon_sponsored_products.user_id,
    date_trunc('week'::text, amazon_sponsored_products.date_time) AS date_time,
    amazon_sponsored_products.portfolio_name,
    amazon_sponsored_products.currency_exchange_rate_id,
    amazon_sponsored_products.campaign_name,
    amazon_sponsored_products.ad_group_name,
    amazon_sponsored_products.sku,
    amazon_sponsored_products.asin,
    sum(amazon_sponsored_products.impressions) AS impressions,
    sum(amazon_sponsored_products.clicks) AS clicks,
    sum(amazon_sponsored_products.ctr) AS ctr,
    sum(amazon_sponsored_products.cpc) AS cpc,
    sum(amazon_sponsored_products.spend) AS spend,
    sum(amazon_sponsored_products.total_sales) AS total_sales,
    sum(amazon_sponsored_products.acos) AS acos,
    sum(amazon_sponsored_products.roas) AS roas,
    sum(amazon_sponsored_products.total_orders) AS total_orders,
    sum(amazon_sponsored_products.total_units) AS total_units,
    avg(amazon_sponsored_products.conversion_rate) AS conversion_rate,
    sum(amazon_sponsored_products.advertised_sku_units) AS advertised_sku_units,
    sum(amazon_sponsored_products.other_sku_units) AS other_sku_units,
    sum(amazon_sponsored_products.advertised_sku_sales) AS advertised_sku_sales,
    sum(amazon_sponsored_products.other_sku_sales) AS other_sku_sales
   FROM public.amazon_sponsored_products
  WHERE ((amazon_sponsored_products.date_time >= (now() - '1 year'::interval)) AND (amazon_sponsored_products.date_time <= (now() - '6 mons'::interval)))
  GROUP BY amazon_sponsored_products.user_id, (date_trunc('week'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.portfolio_name, amazon_sponsored_products.currency_exchange_rate_id, amazon_sponsored_products.campaign_name, amazon_sponsored_products.ad_group_name, amazon_sponsored_products.sku, amazon_sponsored_products.asin
  ORDER BY (date_trunc('week'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.currency_exchange_rate_id
  WITH NO DATA;


--
-- Name: amazon_sponsored_products_previous_thirty_days; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_sponsored_products_previous_thirty_days AS
 SELECT amazon_sponsored_products.user_id,
    date_trunc('day'::text, amazon_sponsored_products.date_time) AS date_time,
    amazon_sponsored_products.portfolio_name,
    amazon_sponsored_products.currency_exchange_rate_id,
    amazon_sponsored_products.campaign_name,
    amazon_sponsored_products.ad_group_name,
    amazon_sponsored_products.sku,
    amazon_sponsored_products.asin,
    sum(amazon_sponsored_products.impressions) AS impressions,
    sum(amazon_sponsored_products.clicks) AS clicks,
    sum(amazon_sponsored_products.ctr) AS ctr,
    sum(amazon_sponsored_products.cpc) AS cpc,
    sum(amazon_sponsored_products.spend) AS spend,
    sum(amazon_sponsored_products.total_sales) AS total_sales,
    sum(amazon_sponsored_products.acos) AS acos,
    sum(amazon_sponsored_products.roas) AS roas,
    sum(amazon_sponsored_products.total_orders) AS total_orders,
    sum(amazon_sponsored_products.total_units) AS total_units,
    avg(amazon_sponsored_products.conversion_rate) AS conversion_rate,
    sum(amazon_sponsored_products.advertised_sku_units) AS advertised_sku_units,
    sum(amazon_sponsored_products.other_sku_units) AS other_sku_units,
    sum(amazon_sponsored_products.advertised_sku_sales) AS advertised_sku_sales,
    sum(amazon_sponsored_products.other_sku_sales) AS other_sku_sales
   FROM public.amazon_sponsored_products
  WHERE ((amazon_sponsored_products.date_time >= (date_trunc('day'::text, now()) - '60 days'::interval)) AND (amazon_sponsored_products.date_time <= ((date_trunc('day'::text, now()) - '30 days'::interval) - '00:00:01'::interval)))
  GROUP BY amazon_sponsored_products.user_id, (date_trunc('day'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.portfolio_name, amazon_sponsored_products.currency_exchange_rate_id, amazon_sponsored_products.campaign_name, amazon_sponsored_products.ad_group_name, amazon_sponsored_products.sku, amazon_sponsored_products.asin
  ORDER BY (date_trunc('day'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.currency_exchange_rate_id
  WITH NO DATA;


--
-- Name: amazon_sponsored_products_previous_three_months; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_sponsored_products_previous_three_months AS
 SELECT amazon_sponsored_products.user_id,
    date_trunc('week'::text, amazon_sponsored_products.date_time) AS date_time,
    amazon_sponsored_products.portfolio_name,
    amazon_sponsored_products.currency_exchange_rate_id,
    amazon_sponsored_products.campaign_name,
    amazon_sponsored_products.ad_group_name,
    amazon_sponsored_products.sku,
    amazon_sponsored_products.asin,
    sum(amazon_sponsored_products.impressions) AS impressions,
    sum(amazon_sponsored_products.clicks) AS clicks,
    sum(amazon_sponsored_products.ctr) AS ctr,
    sum(amazon_sponsored_products.cpc) AS cpc,
    sum(amazon_sponsored_products.spend) AS spend,
    sum(amazon_sponsored_products.total_sales) AS total_sales,
    sum(amazon_sponsored_products.acos) AS acos,
    sum(amazon_sponsored_products.roas) AS roas,
    sum(amazon_sponsored_products.total_orders) AS total_orders,
    sum(amazon_sponsored_products.total_units) AS total_units,
    avg(amazon_sponsored_products.conversion_rate) AS conversion_rate,
    sum(amazon_sponsored_products.advertised_sku_units) AS advertised_sku_units,
    sum(amazon_sponsored_products.other_sku_units) AS other_sku_units,
    sum(amazon_sponsored_products.advertised_sku_sales) AS advertised_sku_sales,
    sum(amazon_sponsored_products.other_sku_sales) AS other_sku_sales
   FROM public.amazon_sponsored_products
  WHERE ((amazon_sponsored_products.date_time >= (now() - '6 mons'::interval)) AND (amazon_sponsored_products.date_time <= (now() - '3 mons'::interval)))
  GROUP BY amazon_sponsored_products.user_id, (date_trunc('week'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.portfolio_name, amazon_sponsored_products.currency_exchange_rate_id, amazon_sponsored_products.campaign_name, amazon_sponsored_products.ad_group_name, amazon_sponsored_products.sku, amazon_sponsored_products.asin
  ORDER BY (date_trunc('week'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.currency_exchange_rate_id
  WITH NO DATA;


--
-- Name: amazon_sponsored_products_this_month; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_sponsored_products_this_month AS
 SELECT amazon_sponsored_products.user_id,
    date_trunc('day'::text, amazon_sponsored_products.date_time) AS date_time,
    amazon_sponsored_products.portfolio_name,
    amazon_sponsored_products.currency_exchange_rate_id,
    amazon_sponsored_products.campaign_name,
    amazon_sponsored_products.ad_group_name,
    amazon_sponsored_products.sku,
    amazon_sponsored_products.asin,
    sum(amazon_sponsored_products.impressions) AS impressions,
    sum(amazon_sponsored_products.clicks) AS clicks,
    sum(amazon_sponsored_products.ctr) AS ctr,
    sum(amazon_sponsored_products.cpc) AS cpc,
    sum(amazon_sponsored_products.spend) AS spend,
    sum(amazon_sponsored_products.total_sales) AS total_sales,
    sum(amazon_sponsored_products.acos) AS acos,
    sum(amazon_sponsored_products.roas) AS roas,
    sum(amazon_sponsored_products.total_orders) AS total_orders,
    sum(amazon_sponsored_products.total_units) AS total_units,
    avg(amazon_sponsored_products.conversion_rate) AS conversion_rate,
    sum(amazon_sponsored_products.advertised_sku_units) AS advertised_sku_units,
    sum(amazon_sponsored_products.other_sku_units) AS other_sku_units,
    sum(amazon_sponsored_products.advertised_sku_sales) AS advertised_sku_sales,
    sum(amazon_sponsored_products.other_sku_sales) AS other_sku_sales
   FROM public.amazon_sponsored_products
  WHERE ((amazon_sponsored_products.date_time >= date_trunc('month'::text, now())) AND (amazon_sponsored_products.date_time <= ((date_trunc('month'::text, now()) + '1 mon'::interval) - '00:00:01'::interval)))
  GROUP BY amazon_sponsored_products.user_id, (date_trunc('day'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.portfolio_name, amazon_sponsored_products.currency_exchange_rate_id, amazon_sponsored_products.campaign_name, amazon_sponsored_products.ad_group_name, amazon_sponsored_products.sku, amazon_sponsored_products.asin
  ORDER BY (date_trunc('day'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.currency_exchange_rate_id
  WITH NO DATA;


--
-- Name: amazon_sponsored_products_this_year; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_sponsored_products_this_year AS
 SELECT amazon_sponsored_products.user_id,
    date_trunc('week'::text, amazon_sponsored_products.date_time) AS date_time,
    amazon_sponsored_products.portfolio_name,
    amazon_sponsored_products.currency_exchange_rate_id,
    amazon_sponsored_products.campaign_name,
    amazon_sponsored_products.ad_group_name,
    amazon_sponsored_products.sku,
    amazon_sponsored_products.asin,
    sum(amazon_sponsored_products.impressions) AS impressions,
    sum(amazon_sponsored_products.clicks) AS clicks,
    sum(amazon_sponsored_products.ctr) AS ctr,
    sum(amazon_sponsored_products.cpc) AS cpc,
    sum(amazon_sponsored_products.spend) AS spend,
    sum(amazon_sponsored_products.total_sales) AS total_sales,
    sum(amazon_sponsored_products.acos) AS acos,
    sum(amazon_sponsored_products.roas) AS roas,
    sum(amazon_sponsored_products.total_orders) AS total_orders,
    sum(amazon_sponsored_products.total_units) AS total_units,
    avg(amazon_sponsored_products.conversion_rate) AS conversion_rate,
    sum(amazon_sponsored_products.advertised_sku_units) AS advertised_sku_units,
    sum(amazon_sponsored_products.other_sku_units) AS other_sku_units,
    sum(amazon_sponsored_products.advertised_sku_sales) AS advertised_sku_sales,
    sum(amazon_sponsored_products.other_sku_sales) AS other_sku_sales
   FROM public.amazon_sponsored_products
  WHERE ((amazon_sponsored_products.date_time >= date_trunc('year'::text, now())) AND (amazon_sponsored_products.date_time <= now()))
  GROUP BY amazon_sponsored_products.user_id, (date_trunc('week'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.portfolio_name, amazon_sponsored_products.currency_exchange_rate_id, amazon_sponsored_products.campaign_name, amazon_sponsored_products.ad_group_name, amazon_sponsored_products.sku, amazon_sponsored_products.asin
  ORDER BY (date_trunc('week'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.currency_exchange_rate_id
  WITH NO DATA;


--
-- Name: amazon_sponsored_products_today; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_sponsored_products_today AS
 SELECT amazon_sponsored_products.user_id,
    date_trunc('day'::text, amazon_sponsored_products.date_time) AS date_time,
    amazon_sponsored_products.portfolio_name,
    amazon_sponsored_products.currency_exchange_rate_id,
    amazon_sponsored_products.campaign_name,
    amazon_sponsored_products.ad_group_name,
    amazon_sponsored_products.sku,
    amazon_sponsored_products.asin,
    sum(amazon_sponsored_products.impressions) AS impressions,
    sum(amazon_sponsored_products.clicks) AS clicks,
    sum(amazon_sponsored_products.ctr) AS ctr,
    sum(amazon_sponsored_products.cpc) AS cpc,
    sum(amazon_sponsored_products.spend) AS spend,
    sum(amazon_sponsored_products.total_sales) AS total_sales,
    sum(amazon_sponsored_products.acos) AS acos,
    sum(amazon_sponsored_products.roas) AS roas,
    sum(amazon_sponsored_products.total_orders) AS total_orders,
    sum(amazon_sponsored_products.total_units) AS total_units,
    avg(amazon_sponsored_products.conversion_rate) AS conversion_rate,
    sum(amazon_sponsored_products.advertised_sku_units) AS advertised_sku_units,
    sum(amazon_sponsored_products.other_sku_units) AS other_sku_units,
    sum(amazon_sponsored_products.advertised_sku_sales) AS advertised_sku_sales,
    sum(amazon_sponsored_products.other_sku_sales) AS other_sku_sales
   FROM public.amazon_sponsored_products
  WHERE ((amazon_sponsored_products.date_time >= date_trunc('day'::text, now())) AND (amazon_sponsored_products.date_time <= ((date_trunc('day'::text, now()) + '1 day'::interval) - '00:00:01'::interval)))
  GROUP BY amazon_sponsored_products.user_id, (date_trunc('day'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.portfolio_name, amazon_sponsored_products.currency_exchange_rate_id, amazon_sponsored_products.campaign_name, amazon_sponsored_products.ad_group_name, amazon_sponsored_products.sku, amazon_sponsored_products.asin
  ORDER BY (date_trunc('day'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.currency_exchange_rate_id
  WITH NO DATA;


--
-- Name: amazon_sponsored_products_yesterday; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_sponsored_products_yesterday AS
 SELECT amazon_sponsored_products.user_id,
    date_trunc('day'::text, amazon_sponsored_products.date_time) AS date_time,
    amazon_sponsored_products.portfolio_name,
    amazon_sponsored_products.currency_exchange_rate_id,
    amazon_sponsored_products.campaign_name,
    amazon_sponsored_products.ad_group_name,
    amazon_sponsored_products.sku,
    amazon_sponsored_products.asin,
    sum(amazon_sponsored_products.impressions) AS impressions,
    sum(amazon_sponsored_products.clicks) AS clicks,
    sum(amazon_sponsored_products.ctr) AS ctr,
    sum(amazon_sponsored_products.cpc) AS cpc,
    sum(amazon_sponsored_products.spend) AS spend,
    sum(amazon_sponsored_products.total_sales) AS total_sales,
    sum(amazon_sponsored_products.acos) AS acos,
    sum(amazon_sponsored_products.roas) AS roas,
    sum(amazon_sponsored_products.total_orders) AS total_orders,
    sum(amazon_sponsored_products.total_units) AS total_units,
    avg(amazon_sponsored_products.conversion_rate) AS conversion_rate,
    sum(amazon_sponsored_products.advertised_sku_units) AS advertised_sku_units,
    sum(amazon_sponsored_products.other_sku_units) AS other_sku_units,
    sum(amazon_sponsored_products.advertised_sku_sales) AS advertised_sku_sales,
    sum(amazon_sponsored_products.other_sku_sales) AS other_sku_sales
   FROM public.amazon_sponsored_products
  WHERE ((amazon_sponsored_products.date_time >= (date_trunc('day'::text, now()) - '1 day'::interval)) AND (amazon_sponsored_products.date_time <= (date_trunc('day'::text, now()) - '00:00:01'::interval)))
  GROUP BY amazon_sponsored_products.user_id, (date_trunc('day'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.portfolio_name, amazon_sponsored_products.currency_exchange_rate_id, amazon_sponsored_products.campaign_name, amazon_sponsored_products.ad_group_name, amazon_sponsored_products.sku, amazon_sponsored_products.asin
  ORDER BY (date_trunc('day'::text, amazon_sponsored_products.date_time)), amazon_sponsored_products.currency_exchange_rate_id
  WITH NO DATA;


--
-- Name: amazon_tax_collection_models; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.amazon_tax_collection_models (
    id bigint NOT NULL,
    name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: amazon_tax_collection_models_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.amazon_tax_collection_models_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: amazon_tax_collection_models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.amazon_tax_collection_models_id_seq OWNED BY public.amazon_tax_collection_models.id;


--
-- Name: amazon_transaction_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.amazon_transaction_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: amazon_transaction_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.amazon_transaction_types_id_seq OWNED BY public.amazon_transaction_types.id;


--
-- Name: amazon_users; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.amazon_users AS
 SELECT DISTINCT amazon_custom_transactions.user_id
   FROM public.amazon_custom_transactions
  WITH NO DATA;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: currency_exchange_rates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.currency_exchange_rates (
    id bigint NOT NULL,
    currency_exchange_rate_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    code character varying NOT NULL,
    exchange_rate numeric(10,2),
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: currency_exchange_rates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.currency_exchange_rates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: currency_exchange_rates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.currency_exchange_rates_id_seq OWNED BY public.currency_exchange_rates.id;


--
-- Name: expenses_others; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.expenses_others (
    id bigint NOT NULL,
    expenses_other_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    currency_exchange_rate_id bigint,
    amount numeric(10,2),
    date_time integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: expenses_others_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.expenses_others_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: expenses_others_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.expenses_others_id_seq OWNED BY public.expenses_others.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: amazon_cost_of_goods id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_cost_of_goods ALTER COLUMN id SET DEFAULT nextval('public.amazon_cost_of_goods_id_seq'::regclass);


--
-- Name: amazon_custom_transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_custom_transactions ALTER COLUMN id SET DEFAULT nextval('public.amazon_custom_transactions_id_seq'::regclass);


--
-- Name: amazon_fulfillments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_fulfillments ALTER COLUMN id SET DEFAULT nextval('public.amazon_fulfillments_id_seq'::regclass);


--
-- Name: amazon_marketplaces id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_marketplaces ALTER COLUMN id SET DEFAULT nextval('public.amazon_marketplaces_id_seq'::regclass);


--
-- Name: amazon_sponsored_products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_sponsored_products ALTER COLUMN id SET DEFAULT nextval('public.amazon_sponsored_products_id_seq'::regclass);


--
-- Name: amazon_tax_collection_models id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_tax_collection_models ALTER COLUMN id SET DEFAULT nextval('public.amazon_tax_collection_models_id_seq'::regclass);


--
-- Name: amazon_transaction_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_transaction_types ALTER COLUMN id SET DEFAULT nextval('public.amazon_transaction_types_id_seq'::regclass);


--
-- Name: currency_exchange_rates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.currency_exchange_rates ALTER COLUMN id SET DEFAULT nextval('public.currency_exchange_rates_id_seq'::regclass);


--
-- Name: expenses_others id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses_others ALTER COLUMN id SET DEFAULT nextval('public.expenses_others_id_seq'::regclass);


--
-- Name: amazon_cost_of_goods amazon_cost_of_goods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_cost_of_goods
    ADD CONSTRAINT amazon_cost_of_goods_pkey PRIMARY KEY (id);


--
-- Name: amazon_custom_transactions amazon_custom_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_custom_transactions
    ADD CONSTRAINT amazon_custom_transactions_pkey PRIMARY KEY (id);


--
-- Name: amazon_fulfillments amazon_fulfillments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_fulfillments
    ADD CONSTRAINT amazon_fulfillments_pkey PRIMARY KEY (id);


--
-- Name: amazon_marketplaces amazon_marketplaces_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_marketplaces
    ADD CONSTRAINT amazon_marketplaces_pkey PRIMARY KEY (id);


--
-- Name: amazon_sponsored_products amazon_sponsored_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_sponsored_products
    ADD CONSTRAINT amazon_sponsored_products_pkey PRIMARY KEY (id);


--
-- Name: amazon_tax_collection_models amazon_tax_collection_models_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_tax_collection_models
    ADD CONSTRAINT amazon_tax_collection_models_pkey PRIMARY KEY (id);


--
-- Name: amazon_transaction_types amazon_transaction_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_transaction_types
    ADD CONSTRAINT amazon_transaction_types_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: currency_exchange_rates currency_exchange_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.currency_exchange_rates
    ADD CONSTRAINT currency_exchange_rates_pkey PRIMARY KEY (id);


--
-- Name: expenses_others expenses_others_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses_others
    ADD CONSTRAINT expenses_others_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: amazon_cost_of_goods_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX amazon_cost_of_goods_unique ON public.amazon_cost_of_goods USING btree (user_id, amazon_marketplace_id, sku, date_time);


--
-- Name: amazon_sponsored_products_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX amazon_sponsored_products_unique ON public.amazon_sponsored_products USING btree (user_id, date_time, portfolio_name, campaign_name, ad_group_name, sku, asin);


--
-- Name: idx_amazon_cost_of_goods_amazon_marketplace_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_amazon_cost_of_goods_amazon_marketplace_id ON public.amazon_cost_of_goods USING btree (amazon_marketplace_id);


--
-- Name: idx_amazon_custom_transactions_amazon_fulfillment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_amazon_custom_transactions_amazon_fulfillment_id ON public.amazon_custom_transactions USING btree (amazon_fulfillment_id);


--
-- Name: idx_amazon_custom_transactions_amazon_marketplace_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_amazon_custom_transactions_amazon_marketplace_id ON public.amazon_custom_transactions USING btree (amazon_marketplace_id);


--
-- Name: idx_amazon_custom_transactions_amazon_tax_collection_model_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_amazon_custom_transactions_amazon_tax_collection_model_id ON public.amazon_custom_transactions USING btree (amazon_tax_collection_model_id);


--
-- Name: idx_amazon_custom_transactions_amazon_transaction_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_amazon_custom_transactions_amazon_transaction_type_id ON public.amazon_custom_transactions USING btree (amazon_transaction_type_id);


--
-- Name: idx_amazon_marketplaces_currency_exchange_rate_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_amazon_marketplaces_currency_exchange_rate_id ON public.amazon_marketplaces USING btree (currency_exchange_rate_id);


--
-- Name: idx_amazon_sponsored_products_currency_exchange_rate_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_amazon_sponsored_products_currency_exchange_rate_id ON public.amazon_sponsored_products USING btree (currency_exchange_rate_id);


--
-- Name: idx_expenses_others_currency_exchange_rate_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_expenses_others_currency_exchange_rate_id ON public.expenses_others USING btree (currency_exchange_rate_id);


--
-- Name: index_amazon_custom_transactions_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_amazon_custom_transactions_unique ON public.amazon_custom_transactions USING btree (user_id, date_time, settlement_id, amazon_transaction_type_id, order_id, sku, total);


--
-- Name: index_amazon_fulfillments_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_amazon_fulfillments_on_name ON public.amazon_fulfillments USING btree (name);


--
-- Name: index_amazon_marketplaces_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_amazon_marketplaces_on_name ON public.amazon_marketplaces USING btree (name);


--
-- Name: index_amazon_tax_collection_models_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_amazon_tax_collection_models_on_name ON public.amazon_tax_collection_models USING btree (name);


--
-- Name: index_amazon_transaction_types_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_amazon_transaction_types_on_name ON public.amazon_transaction_types USING btree (name);


--
-- Name: index_currency_exchange_rates_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_currency_exchange_rates_on_code ON public.currency_exchange_rates USING btree (code);


--
-- Name: amazon_cost_of_goods fk_rails_11fc29636f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_cost_of_goods
    ADD CONSTRAINT fk_rails_11fc29636f FOREIGN KEY (amazon_marketplace_id) REFERENCES public.amazon_marketplaces(id);


--
-- Name: amazon_sponsored_products fk_rails_36b8a45761; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_sponsored_products
    ADD CONSTRAINT fk_rails_36b8a45761 FOREIGN KEY (currency_exchange_rate_id) REFERENCES public.currency_exchange_rates(id);


--
-- Name: amazon_custom_transactions fk_rails_3da7dc7261; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_custom_transactions
    ADD CONSTRAINT fk_rails_3da7dc7261 FOREIGN KEY (amazon_tax_collection_model_id) REFERENCES public.amazon_tax_collection_models(id);


--
-- Name: expenses_others fk_rails_8bf430f3ed; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses_others
    ADD CONSTRAINT fk_rails_8bf430f3ed FOREIGN KEY (currency_exchange_rate_id) REFERENCES public.currency_exchange_rates(id);


--
-- Name: amazon_custom_transactions fk_rails_a42ec4c6b3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_custom_transactions
    ADD CONSTRAINT fk_rails_a42ec4c6b3 FOREIGN KEY (amazon_marketplace_id) REFERENCES public.amazon_marketplaces(id);


--
-- Name: amazon_marketplaces fk_rails_b651c60c22; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_marketplaces
    ADD CONSTRAINT fk_rails_b651c60c22 FOREIGN KEY (currency_exchange_rate_id) REFERENCES public.currency_exchange_rates(id);


--
-- Name: amazon_custom_transactions fk_rails_c90523ee83; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_custom_transactions
    ADD CONSTRAINT fk_rails_c90523ee83 FOREIGN KEY (amazon_transaction_type_id) REFERENCES public.amazon_transaction_types(id);


--
-- Name: amazon_custom_transactions fk_rails_e1b9394164; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_custom_transactions
    ADD CONSTRAINT fk_rails_e1b9394164 FOREIGN KEY (amazon_fulfillment_id) REFERENCES public.amazon_fulfillments(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20201112184507'),
('20201112184637'),
('20201112190627'),
('20201112191003'),
('20201112191924'),
('20201112192648'),
('20201112192940'),
('20201112193201'),
('20201112194039'),
('20201112195020'),
('20201112195126'),
('20201112195548'),
('20201117095724'),
('20201117101237'),
('20201117101251'),
('20201117101257'),
('20201117101310'),
('20201117101314'),
('20201117101320'),
('20201117101326'),
('20201117101331'),
('20201117101336'),
('20201117101348'),
('20201117101352'),
('20201117101357'),
('20201117102520'),
('20201121020438'),
('20201121021715'),
('20201121021723'),
('20201121021735'),
('20201121021744'),
('20201121021748'),
('20201121021753'),
('20201121021801'),
('20201121021807'),
('20201121021816'),
('20201121021821'),
('20201121021833'),
('20201121021836'),
('20201121021840');


