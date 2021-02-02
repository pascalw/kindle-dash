use chrono::Utc;
use chrono_tz::Tz;

const HELP: &str = "\
USAGE:
  next-wakeup --schedule '2,32 8-17 * * MON-FRI' --timezone 'Europe/Amsterdam'
  next-wakeup -s='2,32 8-17 * * MON-FRI' -tz='Europe/Amsterdam'

OPTIONS:
  -tz, --timezone STRING     Timezone used to interpret the cron schedule
  -s,  --schedule STRING     Cron schedule to calculate next wakeup
  -h,  --help                Prints help information
";

#[derive(Debug)]
struct Args {
    timezone: Tz,
    schedule: String,
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

    let now = Utc::now().with_timezone(&args.timezone);
    let next = cron_parser::parse(&schedule, &now).expect("Invalid cron schedule");

    let diff = next - now;

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
