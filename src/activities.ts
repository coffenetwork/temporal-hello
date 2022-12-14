import { Client, ResultIterator } from "ts-postgres";
import {DBClient, DBConfig} from "./DBClient";

// @@@SNIPSTART typescript-hello-activity
export async function greet(name: string): Promise<string> {
  return `Hello, ${name}!`;
}
// @@@SNIPEND

export async function sendWelcomeEmail(email: string): Promise<void> {
  console.log(`Sending welcome email to ${email}`);
}

export async function sendSubscriptionOverEmail(email: string): Promise<void> {
  console.log(`Sending subscription over email to ${email}`);
}

export async function sendCancelSubscriptionEmail(): Promise<void> {
  console.log(`Sending Subscription canceled email`);
}

export async function saveScheduleToDB(
  beginDate: string,
  endDate: string
): Promise<string> {
  
  //demo function that returns OK
  console.log(`Saving schedule to DB begin: ` + beginDate + " end: " + endDate);
  return "OK";
}

function CreateClient(): DBClient {
  const config:DBConfig = new DBConfig("localhost",54320,"user","password","content");
  return new DBClient(config);
}

export async function getAllSchedules(): Promise<ResultIterator |null> {
  const client:DBClient = CreateClient();
  const result = await client.GetAllSchedules();
  console.log("got to activity getAllSchedules");
  return result;
}

export async function AddSchedule(startDate:string, endDate:string, contentId:string): Promise<ResultIterator |null>{
  const client:DBClient = CreateClient();
  const result = await client.AddSchedule(startDate, endDate, contentId);
  return result;
}

export async function DeleteSchedule(scheduleId:string): Promise<ResultIterator |null>{
  const client:DBClient = CreateClient();
  const result = await client.DeleteSchedule(scheduleId);
  return result;
}

export async function UpdateSchedule(scheduleId:string, startDate:string, endDate:string, contentId:string): Promise<ResultIterator |null>{
  const client:DBClient = CreateClient();
  const result = await client.UpdateSchedule(scheduleId, contentId, startDate, endDate );
  return result;
}


