use cron::Schedule;
use chrono::Utc;
use chrono_tz::Tz;

const HELP: &str = "\
USAGE:
  next-wakeup --schedule '0 2-32 8-18 * * 2,6' --timezone 'Europe/Amsterdam'
  next-wakeup -s='0 2-32 8-18 * * 2,6' -tz='Europe/Amsterdam'

OPTIONS:
  -tz, --timezone STRING     Timezone used to interpret the cron schedule
  -s,  --schedule STRING     Cron schedule to calculate next wakeup
  -h,  --help                Prints help information
";

#[derive(Debug)]
struct Args {
    timezone: Tz,
    schedule: Schedule,
}

fn main() {
    let args = match parse_args() {
        Ok(v) => v,
        Err(e) => {
            eprintln!("Error: {}.", e);
            std::process::exit(1);
        }
    };

    let schedule = args.schedule;

    let next = schedule.upcoming(args.timezone).take(1).next().unwrap();
    let next_utc = next.with_timezone(&Utc);

    let now_utc = Utc::now();

    let diff = next_utc - now_utc;

    println!("{}", diff.num_seconds());
}

fn parse_args() -> Result<Args, pico_args::Error> {
    let mut pargs = pico_args::Arguments::from_env();

    if pargs.contains(["-h", "--help"]) {
        print!("{}", HELP);
        std::process::exit(1);
    }

    let args = Args {
        timezone: pargs.value_from_str(["-tz", "--timezone"])?,
        schedule: pargs.value_from_str(["-s", "--schedule"])?
    };

    Ok(args)
}
