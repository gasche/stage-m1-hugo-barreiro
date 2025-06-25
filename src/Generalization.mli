(* Type of scheme *)

type scheme

(* Functions on schemes *)

val body : scheme -> Unif.var

val quantifiers : scheme -> Unif.var list

val debug_scheme : scheme -> PPrint.document

(* Generalization environment *)

type rank := Unif.rank
type var := Constraint.variable

val base_rank : int (* The top-level rank *)

module Env : sig
  type t

  val empty : t

  val is_empty : t -> bool

  (* Young generation *)

  val get_young : t -> rank

  val incr_young : t -> t

  val decr_young : t -> t

  (* Pool functions *)

  val pool_is_empty : rank:rank -> t -> bool

  val get_pool : rank:rank -> t -> var list

  val add_to_pool : var -> rank:rank -> t -> t

  val clean_pool : rank:rank -> t -> t

  (* Debugging functions *)

  val debug : Unif.Env.t -> t -> PPrint.document
end

(* Functions for generalization *)

val enter : Env.t -> Env.t

val exit : Unif.Env.t -> Env.t -> var list -> Unif.Env.t * Env.t * scheme list

val instantiate :
  Unif.Env.t -> Env.t -> scheme ->
  Unif.Env.t * Env.t * Unif.var * Unif.var list
