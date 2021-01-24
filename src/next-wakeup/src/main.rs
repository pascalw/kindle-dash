use std::str::FromStr;
use std::env;
use cron::Schedule;
use chrono::Utc;
use chrono_tz::Europe::Amsterdam;

fn main() {
    let args: Vec<String> = env::args().collect();
    let cron_expr = &args[1];

    let schedule = Schedule::from_str(cron_expr).unwrap();

    let next = schedule.upcoming(Amsterdam).take(1).next().unwrap();
    let next_utc = next.with_timezone(&Utc);

    let now_utc = Utc::now();

    let diff = next_utc - now_utc;

    println!("{}", diff.num_seconds());
}
